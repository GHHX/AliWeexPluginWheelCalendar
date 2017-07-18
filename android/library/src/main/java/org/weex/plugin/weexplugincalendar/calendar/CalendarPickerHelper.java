package org.weex.plugin.weexplugincalendar.calendar;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;

import com.squareup.timessquare.plugin.ITimeClock;

import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.plugin.MvpClock;
import org.weex.plugin.weexplugincalendar.calendar.ui.CalendarPickerActivity;
import org.weex.plugin.weexplugincalendar.calendar.ui.CalendarPickerLandActivity;

/**
 * Created by pengfei on 17/2/27.
 */
public class CalendarPickerHelper {

    public static final String EXTRA_OPTION = "extra_options";

    private static CalendarPickerHelper ourInstance = new CalendarPickerHelper();

    private OnResultListener listener;

    private boolean isStarted;

    private ITimeClock clock = new MvpClock();

    public static CalendarPickerHelper getInstance() {
        return ourInstance;
    }

    private CalendarPickerHelper() {
    }


    public void startPicker(Context context, CalendarOptions options, OnResultListener listener) {
        //LogUtil.d("wpf", "startPicker:" + JSON.toJSON(options));
        if (isStarted) {
            return;
        }

        try {
            this.listener = listener;
            parseCalendarConfig(options);
            Intent intent = new Intent(context, CalendarPickerActivity.class);
            if (options.screenOrientation == ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE) {
                intent.setClass(context, CalendarPickerLandActivity.class);
            }
            intent.putExtra(EXTRA_OPTION, options);
            context.startActivity(intent);
            isStarted = true;
        } catch (Exception e) {
            e.printStackTrace();
            isStarted = false;
        }
    }

    /**
     * 如果config字段为空，则根据bizType查老config，如果查不到，给个默认的。
     * <p>since 1.1.0.
     * @param options
     */
    private void parseCalendarConfig(CalendarOptions options) {
        if (options == null) {
            return;
        }

//        if (options.config == null) {
//            options.config = parseConfigFromBizType(options.bizType);
//        }
        /**
         * 1.4.0引入了currentTs和isSkipFirstDay配置项，在这里做下老版本兼容。
         * 如果没有传入这两个配置项，赋默认值
         */
        if (options.config.currentTs == 0) {
            options.config.currentTs = getCurrentTs();
        }

//        LogUtil.d("Cal", "getConfig/in bizType:" + options.bizType + " config:" + options.config);
    }

    public OnResultListener getResultListener() {
        return this.listener;
    }

    public void setResultListener(OnResultListener listener) {
        this.listener = listener;
    }


    public void setStarted(boolean started) {
        this.isStarted = started;
    }

    /**
     * 根据bizType获取CalendarConfig，老版本使用bizType，1.1.0以后CalendarConfig直传。
     * 新老版本公用CalendarConfig，但是部分字段有版本区别，这里会进行转换
     * @param bizType
     * @return CalendarConfig
     */
//    public static CalendarConfig parseConfigFromBizType(int bizType) {
//        CalendarConfigMo configMo = new CalendarMovieProMovieproConfig().get();
//        CalendarConfig config = null;
//        switch (bizType) {
//            case BizType.BIZ_BOXOFFICE:
//                config = configMo.boxofficeConfig;
//                break;
//            case BizType.BIZ_SCHEDULE:
//                config = configMo.scheduleConfig;
//                break;
//            case BizType.BIZ_CINEMA:
//                config = configMo.cinemaConfig;
//                break;
//            case BizType.BIZ_SHOW:
//                config = configMo.filmConfig;
//                break;
//            default:
//                config = configMo.boxofficeConfig;
//                break;
//        }
//
//        /**
//         * 原有的 presaleForSingle/presaleForRange，从1.1.0版本开始，出于兼容老版本考虑。
//         * 传入老的配置项（包含preSaleForSingle/preSaleForRange）先转成新的配置项。
//         */
//        if (config != null) {
//            if (config.presaleForRange) {
//                config.rangeDayDelta = configMo.presaleDays;
//            }
//            if (config.presaleForSingle) {
//                config.singleDayDelta = configMo.presaleDays;
//            }
//        }
//
//        return config;
//    }

    private long getCurrentTs() {
        if (this.clock != null) {
            return this.clock.currentTimeMillis();
        } else {
            return System.currentTimeMillis();
        }
    }

    public void registerTimeClock(ITimeClock clock) {
        this.clock = clock;
    }

    public ITimeClock getTimeClock() {
        return this.clock;
    }

    public interface OnResultListener {
        void onResult(GroupDateModel select);
        void onCancel();
    }

}
