package com.squareup.timessquare;

import android.content.Context;
import android.text.TextUtils;
import android.text.style.AbsoluteSizeSpan;
import android.text.style.TextAppearanceSpan;
import android.view.View;

import com.binaryfork.spanny.Spanny;
import com.squareup.timessquare.convert.Lunar;
import com.squareup.timessquare.convert.LunarSolarConverter;
import com.squareup.timessquare.convert.Solar;

import org.weex.plugin.weexplugincalendar.R;

import java.text.NumberFormat;

/**
 * Created by pengfei on 17/3/17.
 */

public class DefaultCellViewAdapter implements MonthView.CellViewAdapter {

    @Override
    public void bindMonthView(Context context, MonthDescriptor month, MonthCellDescriptor cell, CalendarCellView preCellView,
            CalendarCellView cellView, NumberFormat numberFormatter,  boolean displayOnly, boolean showInactiveDays) {

        if (cell.getSolar() == null) {
            Solar solar = new Solar();
            solar.solarYear = month.getYear();
            solar.solarMonth = month.getMonth() + 1; // SolarToLunar 会认为是展示值，减1，故在这先加上
            solar.solarDay = cell.getValue();
            Lunar lunar = LunarSolarConverter.SolarToLunar(solar);
            if ("春节".equals(lunar.lunarFestivalName)) {
                if (preCellView != null) {
                    MonthCellDescriptor chuxiCell = (MonthCellDescriptor) preCellView.getTag();
                    chuxiCell.getLunar().lunarFestivalName = "除夕";
                    chuxiCell.setHoliday(true);
                    preCellView.setHoliday(true);
                    preCellView.getDayOfMonthTextView().setText(chuxiCell.getLunar().lunarFestivalName);
                }
            }
            cell.setSolar(solar);
            cell.setLunar(lunar);
        }

        String cellDate = numberFormatter.format(cell.getValue());
        Spanny valueSpan = new Spanny(cellDate);

        // check if festival
        String str = null;
        if (!TextUtils.isEmpty(cell.getSolar().solarFestivalName)) {
            str = cell.getSolar().solarFestivalName;
        } else if (!TextUtils.isEmpty(cell.getLunar().lunarFestivalName)) {
            str = cell.getLunar().lunarFestivalName;
        }
        if (!TextUtils.isEmpty(str)) {
            cell.setHoliday(true);
            cellDate = str;
            valueSpan.clear();
            valueSpan.append(str,
                    new AbsoluteSizeSpan(15, true));
        }
        // check if today
        if (cell.isToday()) {
            cellDate = "今天";
            valueSpan.clear();
            valueSpan.append("今天",
                    new AbsoluteSizeSpan(15, true));
        }

        // add text extra
        if (cell.getExtra() != null && cell.getExtra().length() > 0) {
            cellDate = cellDate + "\n" + cell.getExtra();
            valueSpan.append("\n");
            valueSpan.append(cell.getExtra(),
                    new TextAppearanceSpan(context, R.style.CalendarTextAppearanceShow));
        }

//        if (cell.isAfterToday() && cell.isSelectable()) {
//            valueSpan.append("\n预售", new AbsoluteSizeSpan(10, true));
//        }

        //                    if (!cellView.getDayOfMonthTextView().getText().equals(cellDate)) {
        //                        cellView.getDayOfMonthTextView().setText(cellDate);
        cellView.getDayOfMonthTextView().setText(valueSpan);
        //                    }
        cellView.setEnabled(cell.isCurrentMonth());
        cellView.setClickable(!displayOnly);

        // hide inactive days if showInactiveDays is false
        cellView.setSelectable(cell.isSelectable());
        if (!cellView.isSelectable() && !showInactiveDays) {
            cellView.setVisibility(View.INVISIBLE);
        } else {
            cellView.setVisibility(View.VISIBLE);
        }

        if (!cellView.isSelectable() && cell.isCurrentMonth()) {
            cellView.setVisibility(View.VISIBLE);
        }

        cellView.setSelected(cell.isSelected());
        cellView.setCurrentMonth(cell.isCurrentMonth());
        cellView.setToday(cell.isToday());
        cellView.setRangeState(cell.getRangeState());
        cellView.setHighlighted(cell.isHighlighted());
        cellView.setHoliday(cell.isHoliday());
        cellView.setFuture(cell.isAfterToday() && cell.isSelectable());
        cellView.setTag(cell);

//        if (null != decorators) {
//            for (CalendarCellDecorator decorator : decorators) {
//                decorator.decorate(cellView, cell.getDate());
//            }
//        }
    }
}
