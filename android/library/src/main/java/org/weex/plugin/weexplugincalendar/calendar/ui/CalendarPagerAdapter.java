package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import org.weex.plugin.weexplugincalendar.calendar.CalendarOptions;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarHeader;
import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;

/**
 * Created by pengfei on 17/2/27.
 */

public class CalendarPagerAdapter extends FragmentPagerAdapter {

    private Context context;

    private CalendarHeader[] headers;

    private CalendarOptions options;

    private Bundle bundle;

    public CalendarPagerAdapter(FragmentManager fm, CalendarOptions options) {
        super(fm);
        this.options = options;
    }

    public CalendarPagerAdapter(FragmentManager fm, Context context, Bundle bundle) {
        super(fm);
        this.context = context;
        this.bundle = bundle;
    }

    public void setHeaders(CalendarHeader [] headers) {
        this.headers = headers;
    }

    @Override
    public Fragment getItem(int position) {
        CalendarHeader header = headers[position];
        return createPage(header.type);
    }

    private Fragment createPage(int type) {
        Fragment fragment = null;
        switch (type) {
            case DateUnit.TYPE_DAY:
                fragment = Fragment.instantiate(context, CalendarDayFragment.class.getName(), bundle);
                break;
            case DateUnit.TYPE_WEEK:
                fragment = Fragment.instantiate(context, CalendarWeekFragment.class.getName(), bundle);
                break;
            case DateUnit.TYPE_MONTH:
                fragment = Fragment.instantiate(context, CalendarMonthFragment.class.getName(), bundle);
                break;
            case DateUnit.TYPE_YEAR:
                fragment = Fragment.instantiate(context, CalendarYearFragment.class.getName(), bundle);
                break;
            case DateUnit.TYPE_PERIOD:
                fragment = Fragment.instantiate(context, CalendarPeriodFragment.class.getName(), bundle);
                break;
            case DateUnit.TYPE_CUSTOM:
                fragment = Fragment.instantiate(context, CalendarCustomFragment.class.getName(), bundle);
                break;
        }
        if (fragment != null) {
            fragment.setArguments(bundle);
        }
        return fragment;
    }


    @Override
    public CharSequence getPageTitle(int position) {
        return headers[position].name;
    }

    @Override
    public int getCount() {
        return (headers != null ? headers.length : 0);
    }
}
