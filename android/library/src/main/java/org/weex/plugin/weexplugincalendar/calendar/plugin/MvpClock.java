package org.weex.plugin.weexplugincalendar.calendar.plugin;


import com.squareup.timessquare.plugin.ITimeClock;

/**
 * Created by pengfei on 17/6/15.
 */

public class MvpClock implements ITimeClock {
    @Override
    public long currentTimeMillis() {
        return System.currentTimeMillis();
//        Log.d("wpf", "MvpClock.current/in");
//        return 1497834000000L; // 2017.6.19  第25周周一
//        return 1497229200000l; // 2017.6.12  第24周周一
//        return 1483232400000L; // 2017.1.1 周日
//        return 1497747600000L;// 2017.6.18 周日
//        return 1483318800000L; // 2017.1.2 周一
//        return 1496246400000L; // 2017.6.1
    }
}
