package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.text.TextUtils;
import android.view.View;

import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;

import org.weex.plugin.weexplugincalendar.calendar.SelectMode;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarItemMo;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarMo;
import org.weex.plugin.weexplugincalendar.calendar.model.DateModel;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;
import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;
import org.weex.plugin.weexplugincalendar.calendar.vm.BaseSubYearItem;
import org.weex.plugin.weexplugincalendar.calendar.vm.SubYearLabelItem;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by pengfei on 17/2/27.
 */

public class CalendarPeriodFragment extends CalendarWMPFragment {

    private int initScrollToPos = -1;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        this.mode = SelectMode.SINGLE;
        rangeConfirmContainer.setVisibility(View.GONE);
        staticToast.setVisibility(View.GONE);

        if (initScrollToPos != -1) {
            LinearLayoutManager layoutManager = (LinearLayoutManager) rightListView.getLayoutManager();
            layoutManager.scrollToPosition(initScrollToPos);
        }
    }

    @Override
    protected List<BaseSubYearItem> createData(int startYear, int endYear) {
        // get passed in selected
        String selectId = null;
        if (options.currentModel != null && options.currentModel.type == DateUnit.TYPE_PERIOD) {
            selectId = options.currentModel.toPeriodId();
        }

        // below two is what we need for list
        List<BaseSubYearItem> dataList = new ArrayList<>();
        labelPositionMap = new HashMap<>();

        List<CalendarMo> calendarMos = null; //DataVersionSyncMgr.get().getCalendarList();

        if (calendarMos == null || calendarMos.size() <= 0) {
            // todo  sync now?
            return dataList;
        }
        /**
         * since 1.1.0 end year can be configured!
         */
        Calendar calendar = CalendarUtil.getCalendarInstance();
        calendar.setTimeInMillis(options.config.currentTs);
        calendar.add(Calendar.YEAR, options.config.periodDelta);
        endYear = calendar.get(Calendar.YEAR);

        Date endDate = calendar.getTime();

        int currYear;
        int labelPosition;
        int actualEndYear = -1; // 由于档期不是自己算的，服务端下发的档期可能没有endYear的，在这里判断下
        for (CalendarMo calendarMo: calendarMos) {
            if (calendarMo.calendarItemList == null || calendarMo.calendarItemList.size() <= 0
                    || calendarMo.year < startYear || calendarMo.year > endYear) {
                continue;
            }
            if (actualEndYear == -1) {
                actualEndYear = calendarMo.year;
            }
//            if (currYear != calendarMo.year) { // add header
                labelPosition = dataList.size();
                currYear = calendarMo.year;
                dataList.add(new SubYearLabelItem(currYear + "年", String.valueOf(currYear)));
                labelPositionMap.put(String.valueOf(calendarMo.year), labelPosition);
//            }

            for (CalendarItemMo item: calendarMo.calendarItemList) {
                GroupDateModel model = new GroupDateModel();
                // 检查档期的开始时间是否在今天以前，否则跳过
                try {
                    Date date = CalendarUtil.DEFAULT_FORMATER.parse(item.beginDate);
                    if (date == null || endDate.before(date)) {
                        continue;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    continue;
                }
                model.type = DateUnit.TYPE_PERIOD;
                model.dateAlias = item.name;
                model.start = DateModel.from(item.beginDate);
                model.start.periodYear = item.year;
                model.end = DateModel.from(item.endDate);
                model.end.periodYear = item.year;

                PeriodItem dataItem = new PeriodItem(model, labelPosition);

                // check if should select
                dataItem.isSelected = shouldSelected(model, selectId, dataList.size());

                dataList.add(dataItem);
            }

        }

        // init left year list in case we changed start or end year
        if (actualEndYear != -1) {
            initLeftYearList(startYear, actualEndYear);
        } else {
            initLeftYearList(startYear, endYear);
        }

        return dataList;
    }

    private boolean shouldSelected(GroupDateModel model, String selectId, int position) {
        if (model == null || model.start == null || TextUtils.isEmpty(selectId)) {
            return false;
        }
        String periodId = model.toPeriodId();
        if (selectId.equals(periodId)) {
            selectedDates.add(model);
            initScrollToPos = position;
            return true;
        }
        return false;
    }

    public static class PeriodItem extends BaseSubYearItem<BaseSubYearItem.RightItemViewHolder> {

        public GroupDateModel model;

        PeriodItem(GroupDateModel model, int labelPos) {
            this(model, labelPos, false);
        }

        PeriodItem(GroupDateModel model, int labelPos, boolean isCurrent) {
            this.model = model;
            this.labelPos = labelPos;
            this.isCurrent = isCurrent;
        }

        @Override
        public int getViewType() {
            return BaseSubYearItem.TYPE_WEEK;
        }

        @Override
        public void bindView(Context context, RightItemViewHolder viewHolder) {
            super.bindView(context, viewHolder);
            viewHolder.title.setText(model.dateAlias);
            StringBuilder builder = new StringBuilder(model.toDayRangeString());
            viewHolder.subtitle.setText(builder.toString());
            if (isSelected) {
                this.getItemView().setSelected(true);
            } else {
                this.getItemView().setSelected(false);
            }
        }
    }

    @Override
    public void onItemClick(BaseViewHolder baseViewHolder, View v, int position, Object data) {
        super.onItemClick(baseViewHolder, v, position, data);
        PeriodItem item =  (PeriodItem) adapter.getItem(position);
        GroupDateModel model = item.model;
        if (mode == SelectMode.SINGLE) {
            v.setSelected(true);
            notifyListener(model);
        }

    }
}
