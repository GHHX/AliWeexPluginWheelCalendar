package com.squareup.timessquare;

import android.view.ContextThemeWrapper;
import android.widget.TextView;

import org.weex.plugin.weexplugincalendar.R;


public class DefaultDayViewAdapter implements DayViewAdapter {
  @Override
  public void makeCellView(CalendarCellView parent) {
      TextView textView = new TextView(
              new ContextThemeWrapper(parent.getContext(), R.style.CalendarCell_CalendarDate));
      textView.setDuplicateParentStateEnabled(true);
      parent.addView(textView);
      parent.setDayOfMonthTextView(textView);
  }

    @Override
    public void bindCellView(CalendarCellView parent, MonthCellDescriptor cell) {
        TextView textView = parent.getDayOfMonthTextView();
        if (cell.isToday()) {
            textView.setText("今天");
        }
    }
}
