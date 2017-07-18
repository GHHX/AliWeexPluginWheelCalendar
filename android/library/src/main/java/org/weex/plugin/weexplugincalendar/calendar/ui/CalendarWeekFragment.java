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
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;
import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;
import org.weex.plugin.weexplugincalendar.calendar.util.WeekUtil;
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

public class CalendarWeekFragment extends CalendarWMPFragment {

    private int passedInWeekStart = -1;
    private int passedInWeekEnd = -1;
    private int initScrollToPos = -1;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        maxUnit = options.config.maxWeeks;
        if (this.mode == SelectMode.RANGE) {
            rangeConfirmContainer.setVisibility(View.VISIBLE);
        } else {
            rangeConfirmContainer.setVisibility(View.GONE);
        }

        initSelectionState();
    }

    @Override
    protected List<BaseSubYearItem> createData(int startYear, int endYear) {
        findModeForType(DateUnit.TYPE_WEEK);
        // decode passed-in selection
        if (options.currentModel != null && options.currentModel.type == DateUnit.TYPE_WEEK) {
            passedInWeekStart = options.currentModel.start.toWeekId();
            passedInWeekEnd = options.currentModel.end.toWeekId();
            if (mode == SelectMode.SINGLE) {// 单选的周，有些是跨年的周，end和start的year不一样。故所有单选强制start和end用同一个
                passedInWeekEnd = passedInWeekStart;
            }
        }
        List<BaseSubYearItem> dataList = new ArrayList<>();
        labelPositionMap = new HashMap<>();

        // 获取周选择区间终点
        Calendar calendar = CalendarUtil.getCalendarInstance();
        calendar.setTimeInMillis(options.config.currentTs);
        int currentWeek = calendar.get(Calendar.WEEK_OF_YEAR);
        int thisWeekId = calendar.get(Calendar.YEAR) * 100 + currentWeek;
        /**
         * since 1.1.0 end week can be configured!
         */
        calendar.add(Calendar.WEEK_OF_YEAR, options.config.weekDelta);

        calendar.setFirstDayOfWeek(CalendarUtil.FIRST_DAY_OF_WEEK);
        calendar.setMinimalDaysInFirstWeek(CalendarUtil.MIN_WEEK_DAYS);
        int endYearWeek = calendar.get(Calendar.WEEK_OF_YEAR);

        /**
         * 某些年的前几天属于上一年的最后一周，如2017年1月1日属于2016年的第52周，2017.1.1时currentWeek为52，
         * 和2017年拼起来，会导致把2017年1-52周的数据都展示出来。
         * 方案：
         * 如果某天属于该年的前7天内，则判断该天的WEEK_OF_MONTH字段是否大于0，小于0表示该天不属于该月的周。
         */
        int dayOfYear = calendar.get(Calendar.DAY_OF_YEAR);
        int weekOfMonth = calendar.get(Calendar.WEEK_OF_MONTH);
        boolean showEndYear = true;
        if (dayOfYear < 7 && weekOfMonth == 0) {
            showEndYear = false;
        }

        /**
         * 今天为本周的第一天时，由于该周第一天还没过完，没有数据，导致该周也没数据，故不显示该周。
         */
        int lastShowWeek = endYearWeek;
        if (options.config.isSkipFirstDay == 1 && calendar.get(Calendar.DAY_OF_WEEK) == Calendar.MONDAY) {
            lastShowWeek --;
        }

        endYear = calendar.get(Calendar.YEAR);
        List<GroupDateModel> endYearWeeks = null;
        if (lastShowWeek > 0 && showEndYear) { // /由于lastShowWeek有可能减1，这里需要判断是否还大于0
            endYearWeeks = WeekUtil.getWeeksByYear(endYear, lastShowWeek);
        }

        if (endYearWeeks != null && endYearWeeks.size() > 0) {
            // add label
            dataList.add(new SubYearLabelItem(endYear + "年", String.valueOf(endYear)));
            labelPositionMap.put(String.valueOf(endYear), 0);
            // add weeks in desc order
            for (int i = endYearWeeks.size() - 1; i >= 0; i--) {
                GroupDateModel model = endYearWeeks.get(i);
                // set type for week,month...
                model.type = DateUnit.TYPE_WEEK;
                WeekItem item = new WeekItem(model, 0,
                        model.start.toWeekId() == thisWeekId);

                // check if this week is selected
                item.isSelected = shouldSelected(model, passedInWeekStart, passedInWeekEnd, dataList.size());
                dataList.add(item);
            }
        }

        // take care of the rest years
        for (int y = endYear - 1; y >= startYear; y--) {
            // add label
            int labelPosition = dataList.size();
            SubYearLabelItem label = new SubYearLabelItem(y + "年", String.valueOf(y));
            dataList.add(label);
            labelPositionMap.put(String.valueOf(y), labelPosition);
            // add weeks in desc order
            List<GroupDateModel> modelList = WeekUtil.getWeeksByYear(y);
            for (int w = modelList.size() - 1; w >= 0; w--) {
                GroupDateModel model = modelList.get(w);
                // set type for week,month...
                model.type = DateUnit.TYPE_WEEK;
                WeekItem item = new WeekItem(model, labelPosition, (model.start.toWeekId() == thisWeekId));

                // check if this week is selected
                item.isSelected = shouldSelected(model, passedInWeekStart, passedInWeekEnd, dataList.size());
                dataList.add(item);
            }
        }

        // init left year list
        initLeftYearList(startYear, (lastShowWeek > 0 && showEndYear)? endYear : (endYear - 1));
        return dataList;
    }

    private boolean shouldSelected(GroupDateModel model, int startId, int endId, int position) {
        if (model == null || model.start == null) {
            return false;
        }
        int weekId = model.toWeekId();
        if (weekId == startId) {
            selectedDates.add(model);
            initScrollToPos = position;
            return true;
        } else if (weekId > startId && weekId < endId) {
            return true;
        } else if (weekId == endId) {
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
            LinearLayoutManager layoutManager = (LinearLayoutManager) rightListView.getLayoutManager();
            layoutManager.scrollToPosition(initScrollToPos);
        }
    }

    @Override
    public void onClick(View v) {
        super.onClick(v);
        if (v == confirmBtn) {
            GroupDateModel model = new GroupDateModel();
            model.type = DateUnit.TYPE_WEEK;
            model.start = selectedDates.get(0).start;
            model.end = selectedDates.get(1).end;
            notifyListener(model);
        }
    }

    public static class WeekItem extends BaseSubYearItem<BaseSubYearItem.RightItemViewHolder> {

        public GroupDateModel model;

        WeekItem(GroupDateModel model, int labelPos) {
            this(model, labelPos, false);
        }

        WeekItem(GroupDateModel model, int labelPos, boolean isCurrent) {
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
            viewHolder.title.setText("第" + model.start.week + "周");
            StringBuilder builder = new StringBuilder(model.toDayRangeString());
            if (isCurrent) {
                builder.append("本周");
            }
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
        WeekItem item =  (WeekItem) adapter.getItem(position);
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
                if (CalendarUtil.isSameWeek(model, selectedDates.get(0))) {
                    rightListView.removeSelectedItem(position);
                    selectedDates.clear();
                    refreshRangeStart(null);
                } else if (!exceedLimit(selectedDates.get(0), model)){ // select all between start & end
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
            startDateView.setText(startDate.toWeekString());
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
        startDateView.setText(startDate.toWeekString());
        endDateView.setText(endDate.toWeekString());
        confirmBtn.setEnabled(true);
        staticToast.setVisibility(View.GONE);
    }

    private boolean exceedLimit(GroupDateModel start, GroupDateModel end) {
        if (start == null || end == null) {
            return false;
        }
        Calendar startCal = CalendarUtil.getCalendarInstance();
        startCal.setTime(start.start.toDate());
        startCal.set(Calendar.HOUR_OF_DAY, 0);
        startCal.set(Calendar.MINUTE, 0);
        startCal.set(Calendar.SECOND, 0);
        startCal.set(Calendar.MILLISECOND, 0);


        Calendar endCal = CalendarUtil.getCalendarInstance();
        endCal.setTime(end.start.toDate());
        endCal.set(Calendar.HOUR_OF_DAY, 0);
        endCal.set(Calendar.MINUTE, 0);
        endCal.set(Calendar.SECOND, 0);
        endCal.set(Calendar.MILLISECOND, 0);


        int daysInterval;
        if (endCal.before(startCal)) {
            daysInterval = CalendarUtil.getDaysInterval(endCal.getTime(), startCal.getTime());
        } else {
            daysInterval = CalendarUtil.getDaysInterval(startCal.getTime(), endCal.getTime());
        }

        int weeksInterval = (daysInterval + 1)/ 7;

        if (weeksInterval + 1 > maxUnit) {
            Toast.makeText(getActivity(), "最多可选择" + maxUnit + "周", Toast.LENGTH_LONG).show();

            return true;
        }
        return false;
    }
}
