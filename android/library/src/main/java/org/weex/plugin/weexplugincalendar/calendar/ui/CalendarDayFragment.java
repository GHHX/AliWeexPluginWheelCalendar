package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.app.AlertDialog;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.squareup.timessquare.CalendarRecyclerView;
import com.squareup.timessquare.MonthCellDescriptor;

import org.weex.plugin.weexplugincalendar.R;
import org.weex.plugin.weexplugincalendar.calendar.CalendarPickerHelper;
import org.weex.plugin.weexplugincalendar.calendar.SelectMode;
import org.weex.plugin.weexplugincalendar.calendar.model.DateModel;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;
import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;

import java.util.Calendar;
import java.util.Date;

/**
 * Created by pengfei on 17/2/27.
 */

public class CalendarDayFragment extends BaseCalendarPageFragment
        implements CalendarRecyclerView.OnDateSelectedListener, CalendarRecyclerView.CellClickInterceptor {

    private static final String TAG = "CalendarDayFragment";
    private CalendarRecyclerView calendar;
    private AlertDialog theDialog;
    private CalendarRecyclerView dialogView;

    // mode is always single here.
    private int mode = SelectMode.SINGLE;

    @Override
    public View onCreateContentView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_calendar_day, null);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        final Calendar endDate = CalendarUtil.getCalendarInstance();
        endDate.setTime(new Date(options.config.currentTs));

        // 日历控件有效区间是末尾闭区间，所以先加1
        endDate.add(Calendar.DAY_OF_MONTH, options.config.singleDayDelta + 1);

        final Calendar startDate = CalendarUtil.getCalendarInstance();
        startDate.set(2016, 0, 1);
        try {
            Date date = CalendarUtil.DEFAULT_FORMATER.parse(options.config.startDate);
            startDate.setTime(date);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Date selectedDate = null;
        if (options.currentModel != null && options.currentModel.type == DateUnit.TYPE_DAY
                && options.currentModel.start != null) {
            selectedDate = options.currentModel.start.toDate();
        }

        calendar = (CalendarRecyclerView) view.findViewById(R.id.calendar_view);
        calendar.setTimeClock(CalendarPickerHelper.getInstance().getTimeClock());
        calendar.setOnDateSelectedListener(this);
        calendar.setCellClickInterceptor(this);
        CalendarRecyclerView.FluentInitializer initializer = calendar.init(startDate.getTime(), endDate.getTime());

        initializer.inMode(CalendarRecyclerView.SelectionMode.SINGLE);
        if (selectedDate != null) {
            initializer.withSelectedDate(selectedDate);
        }

        if (selectedDate != null) {
            if (!calendar.scrollToDate(selectedDate)) {
                calendar.scrollToDate(new Date(options.config.currentTs));
            }
        } else {
            calendar.scrollToDate(new Date(options.config.currentTs));
        }

    }

    private CalendarRecyclerView.SelectionMode getActualMode(int outerMode) {
        CalendarRecyclerView.SelectionMode result = CalendarRecyclerView.SelectionMode.SINGLE;
        switch (outerMode) {
            case SelectMode.SINGLE:
                result = CalendarRecyclerView.SelectionMode.SINGLE;
                break;
            case SelectMode.MULTIPLE:
                result = CalendarRecyclerView.SelectionMode.MULTIPLE;
                break;
            case SelectMode.RANGE:
                result = CalendarRecyclerView.SelectionMode.RANGE;
                break;
        }
        return result;
    }

    @Override
    public void onDateSelected(Date date) {

    }

    @Override
    public void onDateUnselected(Date date) {

    }

    @Override
    public boolean onCellClicked(MonthCellDescriptor cell, Date date) {
        if (cell.isSelectable()) {
            Calendar calendar = CalendarUtil.getCalendarInstance();
            calendar.setTime(date);
            GroupDateModel model = new GroupDateModel();
            model.type = DateUnit.TYPE_DAY;
            model.start = new DateModel(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1,
                    calendar.get(Calendar.DAY_OF_MONTH));
            model.end = new DateModel(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1,
                    calendar.get(Calendar.DAY_OF_MONTH));
            notifyListener(model);
            return true;
        }
        return false;
    }
}
