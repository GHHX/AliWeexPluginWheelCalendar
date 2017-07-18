package org.weex.plugin.weexplugincalendar.calendar.model;

import android.os.Parcel;
import android.os.Parcelable;

import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;

import java.util.Calendar;

/**
 * Created by pengfei on 17/3/1.
 */

public class GroupDateModel implements Parcelable {

    /**
     * 日历类型，{@link DateUnit}
     */
    public int type;

    public String dateAlias;

    public DateModel start;
    public DateModel end;

    public GroupDateModel() {

    }

    protected GroupDateModel(Parcel in) {
        type = in.readInt();
        dateAlias = in.readString();
        start = in.readParcelable(DateModel.class.getClassLoader());
        end = in.readParcelable(DateModel.class.getClassLoader());
    }

    public static final Creator<GroupDateModel> CREATOR = new Creator<GroupDateModel>() {
        @Override
        public GroupDateModel createFromParcel(Parcel in) {
            return new GroupDateModel(in);
        }

        @Override
        public GroupDateModel[] newArray(int size) {
            return new GroupDateModel[size];
        }
    };

    public static GroupDateModel from(Calendar calendar) {
        GroupDateModel model = new GroupDateModel();
        model.type = DateUnit.TYPE_DAY;
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        model.start = new DateModel(year, month, day);
        model.end = new DateModel(year, month, day);
        return model;
    }

    @Override
    public String toString() {
        return type + "[" + start + ":" + end + "]";
    }

    public String toDayRangeString() {
        StringBuilder builder = new StringBuilder();
        builder.append("（");
        builder.append(start.toMMddString());
        builder.append("-");
        builder.append(end.toMMddString());
        builder.append("）");

        return builder.toString();
    }


    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(type);
        dest.writeString(dateAlias);
        dest.writeParcelable(start, flags);
        dest.writeParcelable(end, flags);
    }

    public String toWeekString() {
        StringBuilder builder = new StringBuilder();
        builder.append(start.year).append("年第");
        builder.append(start.week).append("周");
        return builder.toString();
    }

    public String toMonthString() {
        StringBuilder builder = new StringBuilder();
        builder.append(start.year).append("年");
        builder.append(start.month).append("月");
        return builder.toString();
    }

    public String toYearString() {
        StringBuilder builder = new StringBuilder();
        builder.append(start.year).append("年");
        return builder.toString();
    }

    public int toWeekId() {
        return start.weekYear * 100 + start.week;
    }

    public int toMonthId() {
        return start.year * 100 + start.month;
    }

    public String toPeriodId() {
        return String.valueOf(start.periodYear) + dateAlias;
    }
}
