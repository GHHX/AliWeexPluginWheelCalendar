package org.weex.plugin.weexplugincalendar.calendar;

import com.taobao.weex.bridge.JSCallback;

import org.weex.plugin.weexplugincalendar.WeexPluginCalendarModule;

/**
 * Created by pengfei on 17/3/6.
 */

public interface ICalendarAWXModule {

    String exportName = "moviepro-module-calendar";

    /**
     * 当前Module的版本
     */
    String version = "1";

    /**
     * 支持的最小AWeex版本
     */
    String minAWeexVersion = "1";

    /**
     * 最小的Weex版本
     */
    String minWeexVersion = "0.10";

    void startCalendar(CalendarOptions paramJson, JSCallback callbackOk, JSCallback callbackCancel);

    void getNextDate(WeexPluginCalendarModule.ParamModel dateJson, JSCallback callbackOk);

    void getPrevDate(WeexPluginCalendarModule.ParamModel dateJson, JSCallback callback);

    void getCurrent(WeexPluginCalendarModule.GetCurrentParam dateJson, JSCallback callback);

}
