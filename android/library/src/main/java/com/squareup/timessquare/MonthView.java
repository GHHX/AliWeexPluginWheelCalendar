// Copyright 2012 Square, Inc.
package com.squareup.timessquare;

import android.content.Context;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import org.weex.plugin.weexplugincalendar.R;

import java.text.DateFormat;
import java.text.NumberFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

public class MonthView extends LinearLayout {
    //TextView title;
    CalendarGridView grid;
    private Listener listener;
    private List<CalendarCellDecorator> decorators;
    private boolean isRtl;
    private Locale locale;
    private CellViewAdapter cellViewAdapter;

    public static MonthView create(ViewGroup parent, LayoutInflater inflater, DateFormat weekdayNameFormat,
            Listener listener, Calendar today, int dividerColor, int dayBackgroundResId, int dayTextColorResId,
            int titleTextColor, boolean displayHeader, int headerTextColor, Locale locale, DayViewAdapter adapter) {
        return create(parent, inflater, weekdayNameFormat, listener, today, dividerColor, dayBackgroundResId,
                dayTextColorResId, titleTextColor, displayHeader, headerTextColor, null, locale, adapter);
    }

    public static MonthView create(ViewGroup parent, LayoutInflater inflater, DateFormat weekdayNameFormat,
            Listener listener, Calendar today, int dividerColor, int dayBackgroundResId, int dayTextColorResId,
            int titleTextColor, boolean displayHeader, int headerTextColor, List<CalendarCellDecorator> decorators,
            Locale locale, DayViewAdapter adapter) {
        final MonthView view = (MonthView) inflater.inflate(R.layout.month, parent, false);
        view.setDayViewAdapter(adapter);
        view.setDividerColor(dividerColor);
        view.setDayTextColor(dayTextColorResId);
        view.setTitleTextColor(titleTextColor);
        view.setDisplayHeader(displayHeader);
        view.setHeaderTextColor(headerTextColor);

        if (dayBackgroundResId != 0) {
            view.setDayBackground(dayBackgroundResId);
        }

        final int originalDayOfWeek = today.get(Calendar.DAY_OF_WEEK);

        view.isRtl = isRtl(locale);
        view.locale = locale;
        int firstDayOfWeek = today.getFirstDayOfWeek();
        final CalendarRowView headerRow = (CalendarRowView) view.grid.getChildAt(0);
        for (int offset = 0; offset < 7; offset++) {
            today.set(Calendar.DAY_OF_WEEK, getDayOfWeek(firstDayOfWeek, offset, view.isRtl));
            final TextView textView = (TextView) headerRow.getChildAt(offset);
            textView.setText(weekdayNameFormat.format(today.getTime()));
        }
        today.set(Calendar.DAY_OF_WEEK, originalDayOfWeek);
        view.listener = listener;
        view.decorators = decorators;
        return view;
    }

    private static int getDayOfWeek(int firstDayOfWeek, int offset, boolean isRtl) {
        int dayOfWeek = firstDayOfWeek + offset;
        if (isRtl) {
            return 8 - dayOfWeek;
        }
        return dayOfWeek;
    }

    private static boolean isRtl(Locale locale) {
        // TODO convert the build to gradle and use getLayoutDirection instead of this (on 17+)?
        final int directionality = Character.getDirectionality(locale.getDisplayName(locale).charAt(0));
        return directionality == Character.DIRECTIONALITY_RIGHT_TO_LEFT
                || directionality == Character.DIRECTIONALITY_RIGHT_TO_LEFT_ARABIC;
    }

    public MonthView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public void setDecorators(List<CalendarCellDecorator> decorators) {
        this.decorators = decorators;
    }

    public List<CalendarCellDecorator> getDecorators() {
        return decorators;
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        //title = (TextView) findViewById(R.id.title);
        grid = (CalendarGridView) findViewById(R.id.calendar_grid);
    }

    public void init(MonthDescriptor month, List<List<MonthCellDescriptor>> cells, boolean displayOnly,
            Typeface titleTypeface, Typeface dateTypeface) {
        init(month, cells, displayOnly, titleTypeface, dateTypeface, false);
    }

    public void init(MonthDescriptor month, List<List<MonthCellDescriptor>> cells, boolean displayOnly,
            Typeface titleTypeface, Typeface dateTypeface, boolean showInactiveDays) {
        Logr.d("Initializing MonthView (%d) for %s", System.identityHashCode(this), month);
        long start = System.currentTimeMillis();
        //title.setText(month.getLabel());
        NumberFormat numberFormatter = NumberFormat.getInstance(locale);
//        CalendarCellView chuxiCell = null;
        CalendarCellView previousCell = null;
        final int numRows = cells.size();
        grid.setNumRows(numRows);
        for (int i = 0; i < 6; i++) {
            CalendarRowView weekRow = (CalendarRowView) grid.getChildAt(i + 1);
            weekRow.setListener(listener);
            if (i < numRows) {
                weekRow.setVisibility(VISIBLE);
                List<MonthCellDescriptor> week = cells.get(i);
                for (int c = 0; c < week.size(); c++) {
                    MonthCellDescriptor cell = week.get(isRtl ? 6 - c : c);
                    CalendarCellView cellView = (CalendarCellView) weekRow.getChildAt(c);

                    if (cellViewAdapter != null) {
                        cellViewAdapter.bindMonthView(getContext(), month, cell, previousCell, cellView,
                                numberFormatter, displayOnly, showInactiveDays);
                    }
//                    if (cell.getSolar() == null) {
//                        Solar solar = new Solar();
//                        solar.solarYear = month.getYear();
//                        solar.solarMonth = month.getMonth() + 1; // SolarToLunar 会认为是展示值，减1，故在这先加上
//                        solar.solarDay = cell.getValue();
//                        Lunar lunar = LunarSolarConverter.SolarToLunar(solar);
//                        if ("春节".equals(lunar.lunarFestivalName)) {
//                            chuxiCell = previousCell;
//                        }
//                        cell.setSolar(solar);
//                        cell.setLunar(lunar);
//                    }
//
//                    String cellDate = numberFormatter.format(cell.getValue());
//                    Spanny valueSpan = new Spanny(cellDate);
//
//                    // check if festival
//                    String str = null;
//                    if (!TextUtils.isEmpty(cell.getSolar().solarFestivalName)) {
//                        str = cell.getSolar().solarFestivalName;
//                    } else if (!TextUtils.isEmpty(cell.getLunar().lunarFestivalName)) {
//                        str = cell.getLunar().lunarFestivalName;
//                    }
//                    if (!TextUtils.isEmpty(str)) {
//                        cell.setHoliday(true);
//                        cellDate = str;
//                        valueSpan.clear();
//                        valueSpan.append(str,
//                                new AbsoluteSizeSpan(15, true));
//                    }
//                    // check if today
//                    if (cell.isToday()) {
//                        cellDate = "今天";
//                        valueSpan.clear();
//                        valueSpan.append("今天",
//                                new AbsoluteSizeSpan(15, true));
//                    }
//
//                    // add text extra
//                    if (cell.getExtra() != null && cell.getExtra().length() > 0) {
//                        cellDate = cellDate + "\n" + cell.getExtra();
//                        valueSpan.append("\n");
//                        valueSpan.append(cell.getExtra(),
//                                new TextAppearanceSpan(getContext(), R.style.CalendarTextAppearanceShow));
//                    }
//
//                    if (cell.isAfterToday()) {
//                        valueSpan.append("\n预售", new AbsoluteSizeSpan(10, true));
//                    }
//
////                    if (!cellView.getDayOfMonthTextView().getText().equals(cellDate)) {
////                        cellView.getDayOfMonthTextView().setText(cellDate);
//                        cellView.getDayOfMonthTextView().setText(valueSpan);
////                    }
//                    cellView.setEnabled(cell.isCurrentMonth());
//                    cellView.setClickable(!displayOnly);
//
//                    // hide inactive days if showInactiveDays is false
//                    cellView.setSelectable(cell.isSelectable());
//                    if (!cellView.isSelectable() && !showInactiveDays) {
//                        cellView.setVisibility(View.INVISIBLE);
//                    } else {
//                        cellView.setVisibility(View.VISIBLE);
//                    }
//                    cellView.setSelected(cell.isSelected());
//                    cellView.setCurrentMonth(cell.isCurrentMonth());
//                    cellView.setToday(cell.isToday());
//                    cellView.setRangeState(cell.getRangeState());
//                    cellView.setHighlighted(cell.isHighlighted());
//                    cellView.setHoliday(cell.isHoliday());
//                    cellView.setFuture(cell.isAfterToday());
//                    cellView.setTag(cell);

                    if (null != decorators) {
                        for (CalendarCellDecorator decorator : decorators) {
                            decorator.decorate(cellView, cell.getDate());
                        }
                    }
                    previousCell = cellView;
                }
            } else {
                weekRow.setVisibility(GONE);
            }
        }

//        if (chuxiCell != null) {
//            MonthCellDescriptor cell = (MonthCellDescriptor) chuxiCell.getTag();
//            cell.getLunar().lunarFestivalName = "除夕";
//            cell.setHoliday(true);
//            chuxiCell.setHoliday(true);
//            chuxiCell.getDayOfMonthTextView().setText(cell.getLunar().lunarFestivalName);
//        }

        if (titleTypeface != null) {
            //title.setTypeface(titleTypeface);
        }
        if (dateTypeface != null) {
            grid.setTypeface(dateTypeface);
        }

        Logr.d("MonthView.init took %d ms", System.currentTimeMillis() - start);
    }

    public void setDividerColor(int color) {
        grid.setDividerColor(color);
    }

    public void setDayBackground(int resId) {
        grid.setDayBackground(resId);
    }

    public void setDayTextColor(int resId) {
        grid.setDayTextColor(resId);
    }

    public void setDayViewAdapter(DayViewAdapter adapter) {
        grid.setDayViewAdapter(adapter);
    }

    public void setTitleTextColor(int color) {
        //title.setTextColor(color);
    }

    public void setDisplayHeader(boolean displayHeader) {
        grid.setDisplayHeader(displayHeader);
    }

    public void setHeaderTextColor(int color) {
        grid.setHeaderTextColor(color);
    }

    public void setCellAspectRatio(float aspectRatio) {
        grid.setCellAspectRatio(aspectRatio);
    }

    public void setCellViewAdapter(CellViewAdapter adapter) {
        this.cellViewAdapter = adapter;
    }

    public interface Listener {
        void handleClick(MonthCellDescriptor cell);
    }

    public interface CellViewAdapter {
        void bindMonthView(Context context, MonthDescriptor month, MonthCellDescriptor cell, CalendarCellView preCellView,
                CalendarCellView cellView, NumberFormat numberFormatter,  boolean displayOnly, boolean showInactiveDays);
    }
}
