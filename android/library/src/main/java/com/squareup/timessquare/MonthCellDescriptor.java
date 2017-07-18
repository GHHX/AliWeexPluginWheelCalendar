// Copyright 2012 Square, Inc.

package com.squareup.timessquare;

import com.squareup.timessquare.convert.Lunar;
import com.squareup.timessquare.convert.Solar;

import java.util.Date;

/**
 * Describes the state of a particular date cell in a {@link MonthView}.
 */
public class MonthCellDescriptor {
    public enum RangeState {
        NONE, FIRST, MIDDLE, LAST
    }


    private final Date date;
    private final int value;
    private final boolean isCurrentMonth;
    private boolean isSelected;
    private final boolean isToday;
    private final boolean isSelectable;
    private boolean isHighlighted;
    private boolean isHoliday;
    private RangeState rangeState;

    private Lunar lunar;
    private Solar solar;

    private String extra;

    private boolean isAfterToday;

    MonthCellDescriptor(Date date, boolean currentMonth, boolean selectable, boolean selected, boolean today,
            boolean highlighted, boolean holiday, int value, RangeState rangeState) {
        this.date = date;
        isCurrentMonth = currentMonth;
        isSelectable = selectable;
        isHighlighted = highlighted;
        isHoliday = holiday;
        isSelected = selected;
        isToday = today;
        this.value = value;
        this.rangeState = rangeState;
    }

    public Date getDate() {
        return date;
    }

    public boolean isCurrentMonth() {
        return isCurrentMonth;
    }

    public boolean isSelectable() {
        return isSelectable;
    }

    public boolean isSelected() {
        return isSelected;
    }

    public void setSelected(boolean selected) {
        isSelected = selected;
    }

    public boolean isHighlighted() {
        return isHighlighted;
    }

    public boolean isHoliday() {
        return isHoliday;
    }

    public void setHoliday(boolean isHoliday) {
        this.isHoliday = isHoliday;
    }

    void setHighlighted(boolean highlighted) {
        isHighlighted = highlighted;
    }

    public boolean isToday() {
        return isToday;
    }

    public RangeState getRangeState() {
        return rangeState;
    }

    public void setRangeState(RangeState rangeState) {
        this.rangeState = rangeState;
    }

    public int getValue() {
        return value;
    }

    public Lunar getLunar() {
        return lunar;
    }

    public void setLunar(Lunar lunar) {
        this.lunar = lunar;
    }

    public Solar getSolar() {
        return solar;
    }

    public void setSolar(Solar solar) {
        this.solar = solar;
    }

    public String getExtra() {
        return extra;
    }

    public void setExtra(String extra) {
        this.extra = extra;
    }

    public boolean isAfterToday() {
        return isAfterToday;
    }

    public void setAfterToday(boolean afterToday) {
        isAfterToday = afterToday;
    }

    @Override
    public String toString() {
        return "MonthCellDescriptor{" + "date=" + date + ", value=" + value + ", isCurrentMonth=" + isCurrentMonth
                + ", isSelected=" + isSelected + ", isToday=" + isToday + ", isSelectable=" + isSelectable
                + ", isHighlighted=" + isHighlighted + ", rangeState=" + rangeState + '}';
    }
}
