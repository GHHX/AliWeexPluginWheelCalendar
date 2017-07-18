package com.squareup.timessquare.plugin;

/**
 * Created by pengfei on 17/6/15.
 */

public class DefaultClock implements ITimeClock {
    @Override
    public long currentTimeMillis() {
//        return AppConfig.get().currentTimeMillis();
//        Log.d("wpf", "DefaultClock.current/in");
        return System.currentTimeMillis();
    }
}
