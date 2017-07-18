package org.weex.plugin.weexplugincalendar.calendar.model;

import android.os.Parcel;
import android.os.Parcelable;

import org.weex.plugin.weexplugincalendar.calendar.SelectMode;
import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;


/**
 * Created by pengfei on 17/2/27.
 */

public class CalendarHeader implements Parcelable {

    public static final CalendarHeader HEADER_DAY = new CalendarHeader(DateUnit.TYPE_DAY, "日票房", SelectMode.SINGLE);
    public static final CalendarHeader HEADER_WEEK = new CalendarHeader(DateUnit.TYPE_WEEK, "周票房", SelectMode.SINGLE);
    public static final CalendarHeader HEADER_MONTH = new CalendarHeader(DateUnit.TYPE_MONTH, "月票房", SelectMode.SINGLE);
    public static final CalendarHeader HEADER_YEAR = new CalendarHeader(DateUnit.TYPE_YEAR, "年票房", SelectMode.SINGLE);
    public static final CalendarHeader HEADER_PERIOD = new CalendarHeader(DateUnit.TYPE_PERIOD, "档期票房", SelectMode.SINGLE);
    public static final CalendarHeader HEADER_CUSTOM = new CalendarHeader(DateUnit.TYPE_CUSTOM, "自定义", SelectMode.RANGE);

    public static final CalendarHeader HEADER_DAY_RANGE = new CalendarHeader(DateUnit.TYPE_CUSTOM, "日票房", SelectMode.RANGE);
    public static final CalendarHeader HEADER_WEEK_RANGE = new CalendarHeader(DateUnit.TYPE_WEEK, "周票房", SelectMode.RANGE);
    public static final CalendarHeader HEADER_MONTH_RANGE = new CalendarHeader(DateUnit.TYPE_MONTH, "月票房", SelectMode.RANGE);
    public static final CalendarHeader HEADER_YEAR_RANGE = new CalendarHeader(DateUnit.TYPE_YEAR, "年票房", SelectMode.RANGE);

    public int type;

    public String name;

    public int mode;

    public int maxUnit;

    public CalendarHeader() {

    }

    public CalendarHeader(int type, String name, int mode) {
        // todo valid start date
        this.type = type;
        this.name = name;
        this.mode = mode;
    }

    protected CalendarHeader(Parcel in) {
        type = in.readInt();
        name = in.readString();
        mode = in.readInt();
        maxUnit = in.readInt();
    }

    public static final Creator<CalendarHeader> CREATOR = new Creator<CalendarHeader>() {
        @Override
        public CalendarHeader createFromParcel(Parcel in) {
            return new CalendarHeader(in);
        }

        @Override
        public CalendarHeader[] newArray(int size) {
            return new CalendarHeader[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(type);
        dest.writeString(name);
        dest.writeInt(mode);
        dest.writeInt(maxUnit);
    }

}
