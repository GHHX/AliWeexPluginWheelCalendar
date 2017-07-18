package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.timessquare.CalendarRecyclerView;
import com.squareup.timessquare.MonthCellDescriptor;

import org.weex.plugin.weexplugincalendar.R;
import org.weex.plugin.weexplugincalendar.calendar.CalendarPickerHelper;
import org.weex.plugin.weexplugincalendar.calendar.model.DateModel;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;
import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by pengfei on 17/2/27.
 */

public class CalendarCustomFragment extends BaseCalendarPageFragment
        implements CalendarRecyclerView.OnDateSelectedListener, CalendarRecyclerView.OnDateRangeSelectListener,
        View.OnClickListener, CalendarRecyclerView.CellClickInterceptor {

    private CalendarRecyclerView calendar;

    private DateModel startDate;

    private DateModel endDate;

    private int maxDayInterval = 30;

    private TextView startDateView;

    private TextView endDateView;

    private TextView confirmBtn;

    @Override
    public View onCreateContentView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_calendar_custom, null);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        findModeForType(DateUnit.TYPE_CUSTOM);
        maxDayInterval = options.config.maxDays;

        startDateView = (TextView) view.findViewById(R.id.tv_calendar_multi_picker_start_value);
        endDateView = (TextView) view.findViewById(R.id.tv_calendar_multi_picker_end_value);
        confirmBtn = (TextView) view.findViewById(R.id.tv_calendar_multi_picker_confirm);
        confirmBtn.setEnabled(false);
        confirmBtn.setOnClickListener(this);
        final Calendar endDate = CalendarUtil.getCalendarInstance();
        endDate.setTimeInMillis(options.config.currentTs);

        // 日历控件有效区间是末尾闭区间，所以先加1
        endDate.add(Calendar.DAY_OF_MONTH, options.config.rangeDayDelta + 1);

        final Calendar startDate = CalendarUtil.getCalendarInstance();
        startDate.set(2016, 0, 1);
        try {
            Date date = CalendarUtil.DEFAULT_FORMATER.parse(options.config.startDate);
            startDate.setTime(date);
        } catch (Exception e) {
            e.printStackTrace();
        }

        calendar = (CalendarRecyclerView) view.findViewById(R.id.calendar_view);
        calendar.setTimeClock(CalendarPickerHelper.getInstance().getTimeClock());
        if (options.screenOrientation == ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE) {
            calendar.setCellAspectRatio(0.5f);
        }
        //        calendar.setOnDateSelectedListener(this);
        calendar.setOnDateRangeSelectedListener(this);
        calendar.setCellClickInterceptor(this);

        CalendarRecyclerView.FluentInitializer initializer =
        calendar.init(startDate.getTime(), endDate.getTime()); //
        initializer.inMode(CalendarRecyclerView.SelectionMode.RANGE);
        List<Date> selectedDates = getSelectedDates();
        if (selectedDates != null && selectedDates.size() > 0) {
            try {

                initializer.withSelectedDates(selectedDates);
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
                initializer.withSelectedDates(new ArrayList<Date>());
            }
        } else {
            startDateView.setText(null);
            endDateView.setText(null);

            confirmBtn.setEnabled(false);
            staticToast.setVisibility(View.VISIBLE);
            staticToast.setText(R.string.calendar_toast_select_start);
            calendar.scrollToDate(new Date(options.config.currentTs));
        }


    }

    private List<Date> getSelectedDates() {
        if (options.currentModel != null && options.currentModel.type == DateUnit.TYPE_CUSTOM && options.currentModel.start != null && options.currentModel.end != null) {
            List<Date> result = new ArrayList<>();
            Calendar cal = CalendarUtil.getCalendarInstance();
            cal.setTime(options.currentModel.start.toDate());

            Calendar calEnd = CalendarUtil.getCalendarInstance();
            calEnd.setTime(options.currentModel.end.toDate());

            // add start date

//            for (;!CalendarUtil.isSameDay(cal, calEnd);) {
//                result.add(cal.getTime());
//                cal.add(Calendar.DAY_OF_MONTH, 1);
//            }
            result.add(cal.getTime());
            result.add(calEnd.getTime());
            return result;
        }
        return null;
    }

    @Override
    public void onDateSelected(Date date) {
    }

    @Override
    public void onDateUnselected(Date date) {
    }

    @Override
    public void onRangeStartSelected(Date date) {
        startDate = DateModel.from(date);
        startDateView.setText(startDate.toYyyyMMddString());
        endDateView.setText(null);
        confirmBtn.setEnabled(false);
        staticToast.setVisibility(View.VISIBLE);
        staticToast.setText(R.string.calendar_toast_select_end);
    }

    @Override
    public void onRangeEndSelected(Date start, Date end) {
        startDate = DateModel.from(start);
        endDate = DateModel.from(end);

        startDateView.setText(startDate.toYyyyMMddString());
        endDateView.setText(endDate.toYyyyMMddString());

        confirmBtn.setEnabled(true);
        staticToast.setVisibility(View.GONE);
    }

    @Override
    public void onRangeStartUnselected(Date start) {
        startDate = null;
        endDate = null;

        startDateView.setText(null);
        endDateView.setText(null);

        confirmBtn.setEnabled(false);
        staticToast.setVisibility(View.VISIBLE);
        staticToast.setText(R.string.calendar_toast_select_start);
    }

    @Override
    public void onClick(View v) {
        GroupDateModel model = new GroupDateModel();
        model.type = DateUnit.TYPE_CUSTOM;
        model.start = startDate;
        model.end = endDate;

        notifyListener(model);
    }

    @Override
    public boolean onCellClicked(MonthCellDescriptor cell, Date date) {
        // no need to check mode, this is range-selectable only
        if (calendar.getSelectedDates() != null && calendar.getSelectedDates().size() == 1) {
            // check if start-end range exceed max days
            Date start = calendar.getSelectedDates().get(0);
            int daysInterval = 0;
            if (start.before(date)) {
                daysInterval = CalendarUtil.getDaysInterval(start, date);
            } else {
                daysInterval = CalendarUtil.getDaysInterval(date, start);
            }
            daysInterval++; // 时间跨度要加1.例如2月1日-2月2日，interval为1，时间跨度两天
            if (daysInterval > maxDayInterval) {
                Toast.makeText(getActivity(), "最多可选择" + maxDayInterval + "天",
                        Toast.LENGTH_LONG).show();
                return true;
            }
        }
        return false;
    }
}
