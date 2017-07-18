package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.view.View;
import android.widget.Toast;

import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;

import org.weex.plugin.weexplugincalendar.R;
import org.weex.plugin.weexplugincalendar.calendar.SelectMode;
import org.weex.plugin.weexplugincalendar.calendar.model.DateModel;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;
import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;
import org.weex.plugin.weexplugincalendar.calendar.vm.BaseSubYearItem;
import org.weex.plugin.weexplugincalendar.calendar.vm.SubYearLabelItem;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

/**
 * Created by pengfei on 17/2/27.
 */

public class CalendarMonthFragment extends CalendarWMPFragment {

    private int passedInMonthStart = -1;
    private int passedInMonthEnd = -1;
    private int initScrollToPos = -1;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        maxUnit = options.config.maxMoths;
        if (mode == SelectMode.RANGE) {
            rangeConfirmContainer.setVisibility(View.VISIBLE);
        } else {
            rangeConfirmContainer.setVisibility(View.GONE);
        }
        initSelectionState();
    }

    @Override
    protected List<BaseSubYearItem> createData(int startYear, int endYear) {
        mode = findModeForType(DateUnit.TYPE_MONTH);
        if (options.currentModel != null && options.currentModel.type == DateUnit.TYPE_MONTH) {
            passedInMonthStart = options.currentModel.start.toMonthId();
            passedInMonthEnd = options.currentModel.end.toMonthId();
        }

        List<BaseSubYearItem> dataList = new ArrayList<>();
        labelPositionMap = new HashMap<>();

        // 本年的只添加到本月
        Calendar calendar = CalendarUtil.getCalendarInstance();
        calendar.setTimeInMillis(options.config.currentTs);

        int currentMonth = calendar.get(Calendar.MONTH) + 1;
        int thisMonthId = calendar.get(Calendar.YEAR) * 100 + currentMonth;
        /**
         * since 1.1.0 end week can be configured!
         */
        calendar.add(Calendar.MONTH, options.config.monthDelta);

        int endYearMonth = calendar.get(Calendar.MONTH)  + 1;
        endYear = calendar.get(Calendar.YEAR);

        /**
         * 今天为本月的第一天时，由于该月第一天还没过完，没有数据，导致该月也没数据，故不显示该月。
         */
        int lastShowMonth = endYearMonth;
        if (options.config.isSkipFirstDay == 1 && calendar.get(Calendar.DAY_OF_MONTH) == 1) {
            lastShowMonth --;
        }

        List<GroupDateModel> endYearMonths = null;
        if (lastShowMonth > 0) { // 由于lastShowMonth有可能减1，这里需要判断是否还大于0
            endYearMonths = getMonthsByYear(endYear, lastShowMonth);
        }

        if (endYearMonths != null && endYearMonths.size() > 0) {
            // add label
            dataList.add(new SubYearLabelItem(endYear + "年", String.valueOf(endYear)));
            labelPositionMap.put(String.valueOf(endYear), 0);
            // add months of this year in desc order
            for (int i = endYearMonths.size() - 1; i >= 0; i--) {
                GroupDateModel model = endYearMonths.get(i);
                // set type for week,month...
                model.type = DateUnit.TYPE_MONTH;

                // check if should select
                MonthItem item = new MonthItem(model, 0, model.start.toMonthId() == thisMonthId);
                item.isSelected = shouldSelected(model, passedInMonthStart, passedInMonthEnd, dataList.size());
                dataList.add(item);
            }
        }

        // take care of rest years
        for (int y = endYear - 1; y >= startYear; y--) {
            // add label
            int labelPosition = dataList.size();
            SubYearLabelItem label = new SubYearLabelItem(y + "年", String.valueOf(y));
            dataList.add(label);
            labelPositionMap.put(String.valueOf(y), labelPosition);
            // add months in desc order
            List<GroupDateModel> modelList = getMonthsByYear(y);
            for (int w = modelList.size() - 1; w >= 0; w--) {
                GroupDateModel model = modelList.get(w);
                // set type for week,month...
                model.type = DateUnit.TYPE_MONTH;

                MonthItem item = new MonthItem(model, labelPosition, model.start.toMonthId() == thisMonthId);
                item.isSelected = shouldSelected(model, passedInMonthStart, passedInMonthEnd, dataList.size());
                dataList.add(item);
            }
        }

        // init left year list
        initLeftYearList(startYear, lastShowMonth > 0 ? endYear : (endYear - 1));

        return dataList;

    }

    private boolean shouldSelected(GroupDateModel model, int startId, int endId, int position) {
        if (model == null || model.start == null) {
            return false;
        }
        int monthId = model.toMonthId();
        if (monthId == startId) {
            selectedDates.add(model);
            initScrollToPos = position;
            return true;
        } else if (monthId > startId && monthId < endId) {
            return true;
        } else if (monthId == endId) {
            selectedDates.add(model);
            return true;
        }
        return false;
    }

    /**
     * initialize selection state, refresh confirm container of range select mode and scroll to selection
     * @return
     */
    private void initSelectionState() {
        if (selectedDates.size() == 2) {
            refreshRangeEnd();
        } else if(mode == SelectMode.RANGE) {
            refreshRangeStart(null);
        }
        if (initScrollToPos != -1) {
            int scrollPos = initScrollToPos - 5;
            if (scrollPos < 0) {
                scrollPos = 0;
            }
            LinearLayoutManager layoutManager = (LinearLayoutManager) rightListView.getLayoutManager();
            layoutManager.scrollToPosition(scrollPos);
        }
    }

    @Override
    public void onClick(View v) {
        super.onClick(v);
        if (v == confirmBtn) {
            GroupDateModel model = new GroupDateModel();
            model.type = DateUnit.TYPE_MONTH;
            model.start = selectedDates.get(0).start;
            model.end = selectedDates.get(1).end;
            notifyListener(model);
        }
    }

    /**
     *
     * @param year actual year, eg. for 2017, year is 2017
     * @param month actual month, eg. for January, month is 1.
     * @return
     */
    public static List<GroupDateModel> getMonthsByYear(int year, int month) {
        Calendar calendar = CalendarUtil.getCalendarInstance();
        calendar.set(Calendar.YEAR, year);
        List<GroupDateModel> result = new ArrayList<>();
        for (int i = 0; i < month; i++) {
            calendar.set(Calendar.MONTH, i);

            GroupDateModel model = new GroupDateModel();
            DateModel startDate = new DateModel();
            startDate.year = year;
            startDate.month = i + 1; // Calendar类中month起始值为0
            startDate.day = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);

            DateModel endDate = new DateModel();
            endDate.year = year;
            endDate.month = i + 1; // Calendar类中month起始值为0
            endDate.day = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

            model.start = startDate;
            model.end = endDate;

            result.add(model);
        }
        return result;
    }

    public static List<GroupDateModel> getMonthsByYear(int year) {
        return getMonthsByYear(year, 12);
    }

    public static class MonthItem extends BaseSubYearItem<BaseSubYearItem.RightItemViewHolder> {

        public GroupDateModel model;

        MonthItem(GroupDateModel model, int labelPos) {
            this(model, labelPos, false);
        }

        MonthItem(GroupDateModel model, int labelPos, boolean isCurrent) {
            this.model = model;
            this.labelPos = labelPos;
            this.isCurrent = isCurrent;
        }

        @Override
        public int getViewType() {
            return BaseSubYearItem.TYPE_MONTH;
        }

        @Override
        public void bindView(Context context, RightItemViewHolder viewHolder) {
            super.bindView(context, viewHolder);
            viewHolder.title.setText(model.start.month + "月");
            if (isCurrent) {
                viewHolder.subtitle.setVisibility(View.VISIBLE);
                viewHolder.subtitle.setText(R.string.calendar_current_month_label);
            } else {
                viewHolder.subtitle.setVisibility(View.GONE);
            }
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
        MonthItem item =  (MonthItem) adapter.getItem(position);
        GroupDateModel model = item.model;
        if (mode == SelectMode.SINGLE) {
            v.setSelected(true);
            notifyListener(model);
        } else if (mode ==SelectMode.RANGE) {
            if (selectedDates.size() == 0) { // range start
                rightListView.setSelectedItem(position);
                selectedDates.add(model);
                refreshRangeStart(model);
            } else if (selectedDates.size() == 1) {
                // check if click the same week again
                if (CalendarUtil.isSameMonth(model, selectedDates.get(0))) {
                    rightListView.removeSelectedItem(position);
                    selectedDates.clear();
                    refreshRangeStart(null);
                } else if (!exceedLimit(selectedDates.get(0), model)) { // select all between start & end
                    selectedDates.add(model);
                    rightListView.selectRange(position);
                    rightListView.setSelectedItem(position);
                    // refresh range view
                    refreshRangeEnd();
                }
            } else { // clear all selections and select this one
                rightListView.removeAllSelectedItem();
                selectedDates.clear();
                selectedDates.add(model);
                rightListView.setSelectedItem(position);
                refreshRangeStart(model);
            }
        }
    }

    protected void refreshRangeStart(GroupDateModel startDate) {
        if (startDate != null) {
            startDateView.setText(startDate.toMonthString());
            endDateView.setText(null);
            confirmBtn.setEnabled(false);
            staticToast.setVisibility(View.VISIBLE);
            staticToast.setText(R.string.calendar_toast_select_end);
        } else {
            startDateView.setText(null);
            endDateView.setText(null);
            confirmBtn.setEnabled(false);
            staticToast.setVisibility(View.VISIBLE);
            staticToast.setText(R.string.calendar_toast_select_start);
        }
    }

    protected void refreshRangeEnd() {
        GroupDateModel startDate = selectedDates.get(0);
        GroupDateModel endDate = selectedDates.get(1);
        if (startDate == null || endDate == null) {
            return;
        }
        if (CalendarUtil.isBefore(endDate, startDate)) {
            Collections.reverse(selectedDates);
            startDate = selectedDates.get(0);
            endDate = selectedDates.get(1);
        }
        startDateView.setText(startDate.toMonthString());
        endDateView.setText(endDate.toMonthString());
        confirmBtn.setEnabled(true);
        staticToast.setVisibility(View.GONE);
    }

    private boolean exceedLimit(GroupDateModel start, GroupDateModel end) {
        if (start == null || end == null) {
            return false;
        }
        int yearDelta = end.start.year - start.start.year;
        int monthDelta = end.start.month - start.start.month;
        int monthInterval = Math.abs(yearDelta * 12 + monthDelta);
        if (monthInterval + 1 > maxUnit) {
            Toast.makeText(getActivity(), "最多可选择" + maxUnit + "月",
                    Toast.LENGTH_LONG).show();
            return true;
        }
        return false;
    }
}
