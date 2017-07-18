package org.weex.plugin.weexplugincalendar.calendar.model;

import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;

import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;

import java.util.Calendar;
import java.util.Date;

/**
 * Created by pengfei on 17/3/1.
 */

public class DateModel implements Parcelable {

    public int year;
    public int month;
    public int day;
    public int week;
    /**
     * 周所属的年，若周跨年，week不属于year的那一年，如2016年第52周的最后一天，是2017年的1月3日。weekYear=2016，year=2017
     */
    public int weekYear;
    /**
     * 档期所属的年，若档期跨年，如2017年元旦档，是2016年的12月31日-2017-1-2。periodYear=2017，year=2016
     */
    public int periodYear;
    public int period;

    public DateModel(int year, int month, int day) {
        this.year = year;
        this.month = month;
        this.day = day;
    }

    public DateModel() {

    }

    protected DateModel(Parcel in) {
        year = in.readInt();
        month = in.readInt();
        day = in.readInt();
        week = in.readInt();
        period = in.readInt();
        weekYear = in.readInt();
        periodYear = in.readInt();
    }

    public static DateModel from(Date date) {
        if (date == null) {
            return null;
        }
        DateModel model = new DateModel();
        Calendar calendar = CalendarUtil.getCalendarInstance();
        calendar.setTime(date);
        model.year = calendar.get(Calendar.YEAR);
        model.month = calendar.get(Calendar.MONTH) + 1;
        model.day = calendar.get(Calendar.DAY_OF_MONTH);

        return model;
    }

    public static DateModel from(String yymmdd) {
        if (TextUtils.isEmpty(yymmdd) || yymmdd.length() != 8) {
            return null;
        }
        try {
            DateModel model = new DateModel();
            model.year = Integer.valueOf(yymmdd.substring(0, 4));
            model.month = Integer.valueOf(yymmdd.substring(4, 6));
            model.day = Integer.valueOf(yymmdd.substring(6, 8));
            return model;
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (StringIndexOutOfBoundsException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static DateModel from(DateModel other) {
        if (other == null) {
            return null;
        }
        DateModel model = new DateModel();
        model.year = other.year;
        model.month = other.month;
        model.day = other.day;
        model.week = other.week;
        model.period = other.period;
        model.weekYear = other.weekYear;
        model.periodYear = other.periodYear;

        return model;
    }

    public static DateModel from(Calendar calendar) {
        if (calendar == null) {
            return null;
        }
        DateModel model = new DateModel();
        model.year = calendar.get(Calendar.YEAR);
        model.month = calendar.get(Calendar.MONTH) + 1;
        model.day = calendar.get(Calendar.DAY_OF_MONTH);

        return model;
    }

    public static final Creator<DateModel> CREATOR = new Creator<DateModel>() {
        @Override
        public DateModel createFromParcel(Parcel in) {
            return new DateModel(in);
        }

        @Override
        public DateModel[] newArray(int size) {
            return new DateModel[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(year);
        dest.writeInt(month);
        dest.writeInt(day);
        dest.writeInt(week);
        dest.writeInt(period);
        dest.writeInt(weekYear);
        dest.writeInt(periodYear);
    }

    @Override
    public String toString() {
        return year + "-" + month + "-" + day + "(" + weekYear + "w" + week + ")(" + periodYear + ")";
    }

    public String toMMddString() {
        StringBuilder builder = new StringBuilder();
        builder.append(month).append("月");
        builder.append(day).append("日");

        return builder.toString();
    }

    public String toYyyyMMddString() {
        StringBuilder builder = new StringBuilder();
        builder.append(year).append("年");
        builder.append(month).append("月");
        builder.append(day).append("日");

        return builder.toString();
    }

    public String toParamString() {
        StringBuilder builder = new StringBuilder();
        builder.append(year);
        if (month < 10) {
            builder.append(0);
        }
        builder.append(month);
        if (day < 10) {
            builder.append(0);
        }
        builder.append(day);
        return builder.toString();
    }

    public Date toDate() {
        try {
            return CalendarUtil.DEFAULT_FORMATER.parse(toParamString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int toWeekId() {
        return weekYear * 100 + week;
    }

    public int toMonthId() {
        return year * 100 + month;
    }
}
