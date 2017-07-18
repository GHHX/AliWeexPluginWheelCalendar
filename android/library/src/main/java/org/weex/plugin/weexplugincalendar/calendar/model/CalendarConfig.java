package org.weex.plugin.weexplugincalendar.calendar.model;

import android.os.Parcel;
import android.os.Parcelable;

import java.io.Serializable;

/**
 * Created by pengfei on 17/3/16.
 */

public class CalendarConfig implements Serializable, Parcelable {

    /**
     * 日历开始时间，各时间维度共享此配置
     * added in 1.0.0
     */
    public String startDate;

    /**
     * 日单选是否有预售
     * added in 1.0.0.
     */
    public boolean presaleForSingle;

    /**
     * 日多选是否有预售
     * added in 1.0.0.
     */
    public boolean presaleForRange;

    /**
     * 日多选最大间隔天数
     * added in 1.0.0.
     */
    public int maxDays;

    /**
     * 周多选最大间隔周数
     * added in 1.0.0.
     */
    public int maxWeeks;

    /**
     * 月多选最大间隔月数，单词month拼错了，为兼容，就让他错下去
     * added in 1.0.0.
     */
    public int maxMoths;

    /**
     * 年多选最大间隔年数
     * added in 1.0.0.
     */
    public int maxYears;

    /**
     * 日单选结束日期和今天的差值，如需要预售15天，设置为15
     * added in 1.1.0.
     */
    public int singleDayDelta;

    /**
     * 日多选结束日期和今天的差值，如果需要显示到昨天，设置为-1
     * added in 1.1.0.
     */
    public int rangeDayDelta;

    /**
     * 周结束日期和本周的差值，如需要显示到下周，设置为1
     * added in 1.1.0.
     */
    public int weekDelta;

    /**
     * 月结束日期和本月的差值，如果需要显示到下月，设置为1
     * added in 1.1.0.
     */
    public int monthDelta;

    /**
     * 年结束日期和今天的差值，如需要显示到今年，设置为0
     * added in 1.1.0.
     */
    public int yearDelta;

    /**
     * 档期结束日期和今年的差值，如果需要显示到明年的档期，设置为1
     * added in 1.1.0.
     */
    public int periodDelta;

    /**
     * 【可为空，默认取本地时间】当前时间，如果不传使用本地时间
     * added in 1.4.0
     */
    public long currentTs;

    /**
     * 【可为空，默认为0】今天为周一、每月1号，每年1月1号时，是否显示本周、本月、本年。
     * 0：显示，1：不显示。默认0
     *
     * added in 1.4.0
     */
    public int isSkipFirstDay;

    public CalendarConfig() {

    }


    protected CalendarConfig(Parcel in) {
        startDate = in.readString();
        presaleForSingle = in.readByte() != 0;
        presaleForRange = in.readByte() != 0;
        maxDays = in.readInt();
        maxWeeks = in.readInt();
        maxMoths = in.readInt();
        maxYears = in.readInt();
        singleDayDelta = in.readInt();
        rangeDayDelta = in.readInt();
        weekDelta = in.readInt();
        monthDelta = in.readInt();
        yearDelta = in.readInt();
        periodDelta = in.readInt();
        currentTs = in.readLong();
        isSkipFirstDay = in.readInt();
    }

    public static final Creator<CalendarConfig> CREATOR = new Creator<CalendarConfig>() {
        @Override
        public CalendarConfig createFromParcel(Parcel in) {
            return new CalendarConfig(in);
        }

        @Override
        public CalendarConfig[] newArray(int size) {
            return new CalendarConfig[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(startDate);
        dest.writeByte((byte) (presaleForSingle ? 1 : 0));
        dest.writeByte((byte) (presaleForRange ? 1 : 0));
        dest.writeInt(maxDays);
        dest.writeInt(maxWeeks);
        dest.writeInt(maxMoths);
        dest.writeInt(maxYears);
        dest.writeInt(singleDayDelta);
        dest.writeInt(rangeDayDelta);
        dest.writeInt(weekDelta);
        dest.writeInt(monthDelta);
        dest.writeInt(yearDelta);
        dest.writeInt(periodDelta);
        dest.writeLong(currentTs);
        dest.writeInt(isSkipFirstDay);
    }

    @Override
    public String toString() {
        return "{start:" + startDate + " dayDelta:" + singleDayDelta + " daysDelta:" + rangeDayDelta
                + " weekDelta:" + weekDelta + " monthDelta:" + monthDelta + " yearDelta:" + yearDelta
                + " max:[" + maxDays + "," + maxWeeks + "," + maxMoths + "," + maxYears + "}";
    }
}
