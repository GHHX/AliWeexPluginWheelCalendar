package org.weex.plugin.weexplugincalendar.calendar;

import android.content.pm.ActivityInfo;
import android.os.Parcel;
import android.os.Parcelable;

import org.weex.plugin.weexplugincalendar.calendar.model.CalendarConfig;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarHeader;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;


/**
 * Created by pengfei on 17/3/2.
 */

public class CalendarOptions implements Parcelable {

    public CalendarHeader[] headers;

    public GroupDateModel currentModel;

    public int screenOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT;

    /** Added 1.1.0，将配置放在这一层，方便业务方直接传入；老版本通过传入bizType，日历组件自己查找相关配置。
     * 1.1.0之后，老版本传入bizType将在CalendarPickerHelper那层处理，将其解析成config，并且将老版本配置的
     * 老字段转为新字段。
     */
    public CalendarConfig config;

    public CalendarOptions() {

    }

    private CalendarOptions(CalendarHeader [] headers, GroupDateModel model) {
        this(headers, model, ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
    }

    private CalendarOptions(CalendarHeader [] headers, GroupDateModel model, int screenOrientation) {
        this.headers = headers;
        this.currentModel = model;
        this.screenOrientation = screenOrientation;
    }

    protected CalendarOptions(Parcel in) {
        headers = in.createTypedArray(CalendarHeader.CREATOR);
        currentModel = in.readParcelable(GroupDateModel.class.getClassLoader());
        screenOrientation = in.readInt();
        config = in.readParcelable(CalendarConfig.class.getClassLoader());
    }

    public static final Creator<CalendarOptions> CREATOR = new Creator<CalendarOptions>() {
        @Override
        public CalendarOptions createFromParcel(Parcel in) {
            return new CalendarOptions(in);
        }

        @Override
        public CalendarOptions[] newArray(int size) {
            return new CalendarOptions[size];
        }
    };

    public static Builder builder() {
        return new Builder();
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeTypedArray(headers, flags);
        dest.writeParcelable(currentModel, flags);
        dest.writeInt(screenOrientation);
        dest.writeParcelable(config, flags);
    }

    public static class Builder {


        public CalendarHeader [] headers;

        public GroupDateModel currentModel;

        public int screenOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT;

        public Builder setHeaders(CalendarHeader [] headers) {
            this.headers = headers;
            return this;
        }

        public Builder setCurrentDate(GroupDateModel model) {
            this.currentModel = model;
            return this;
        }

        public Builder setOrientation(int orientation) {
            this.screenOrientation = orientation;
            return this;
        }

        public Builder setBizType(int bizType) {
            return this;
        }

        public CalendarOptions build() {
            return new CalendarOptions(this.headers, this.currentModel, this.screenOrientation);
        }
    }

}
