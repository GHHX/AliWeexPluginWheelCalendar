package org.weex.plugin.weexplugincalendar.calendar.util;

/**
 * Created by pengfei on 17/3/4.
 */

public interface DateSelectType {

    int TYPE_DAY = 1;

    int TYPE_WEEK = 2;

    int TYPE_MONTH = 4;

    int TYPE_YEAR = 8;

    int TYPE_PERIOD = 16;

    int TYPE_DAY_MULTIPLE = 32;

    int TYPE_WEEK_MULTIPLE = 64;

    int TYPE_MONTH_MULTIPLE = 128;

    int TYPE_YEAR_MULTIPLE = 256;

    int TYPE_PERIOD_MULTIPLE = 512;
}
