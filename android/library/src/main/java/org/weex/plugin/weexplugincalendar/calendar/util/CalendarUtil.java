package org.weex.plugin.weexplugincalendar.calendar.util;


import org.weex.plugin.weexplugincalendar.calendar.CalendarPickerHelper;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarConfig;
import org.weex.plugin.weexplugincalendar.calendar.model.DateModel;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

/**
 * Created by pengfei on 17/3/4.
 */

public class CalendarUtil {

    private static final String TAG = "CalUtil";

    private static final String TIMEZONE = "GMT+8";

    public static final int FIRST_DAY_OF_WEEK = Calendar.MONDAY;

    public static final int WEEK_FIRST = Calendar.MONDAY;

    public static final int WEEK_END = Calendar.SUNDAY;

    public static final int MIN_WEEK_DAYS = 7;

    public static final SimpleDateFormat DEFAULT_FORMATER = new SimpleDateFormat("yyyyMMdd");

//    private static Calendar MAX_DAY;
//
//    private static Calendar MAX_DAY_PRESALE;
//
//    private static int MAX_YEAR;

//    private static Calendar MAX_MONTH;
//
//    private static Calendar MAX_WEEK;

    private static Calendar DEFAULT_MIN_DAY;

    private static int DEFAULT_MIN_YEAR = 2011;

    private static Calendar DEFAULT_MIN_MONTH;

    private static Calendar DEFAULT_MIN_WEEK;

    static {
        DEFAULT_MIN_DAY = getCalendarInstance();
        DEFAULT_MIN_DAY.set(2011, 0, 1);

        DEFAULT_MIN_WEEK = getCalendarInstance();
        DEFAULT_MIN_WEEK.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);
        DEFAULT_MIN_DAY.setMinimalDaysInFirstWeek(7);
        DEFAULT_MIN_WEEK.set(Calendar.YEAR, 2011);
        DEFAULT_MIN_WEEK.set(Calendar.WEEK_OF_YEAR, 1);
        DEFAULT_MIN_WEEK.set(Calendar.DAY_OF_WEEK, WEEK_FIRST);

        // 本
        DEFAULT_MIN_MONTH = getCalendarInstance();
        DEFAULT_MIN_MONTH.set(Calendar.YEAR, 2011);
        DEFAULT_MIN_MONTH.set(Calendar.MONTH, Calendar.JANUARY);
        DEFAULT_MIN_MONTH.set(Calendar.DAY_OF_MONTH, 1);

    }

    private static int getMaxYear(CalendarConfig config) {
        Calendar calendar = todayCalendar();
        // apply passed-in current time
        if (config != null && config.currentTs > 0) {
            calendar.setTimeInMillis(config.currentTs);
        }

        if (config != null) { // 根据配置修改最大年参考值
            calendar.set(Calendar.DAY_OF_YEAR, calendar.getMinimum(Calendar.DAY_OF_YEAR));
            calendar.add(Calendar.YEAR, config.yearDelta);
        }

        /**
         * 今天为本年的第一天时，由于该年第一天还没过完，今天没有数据，导致该年也没数据，故不显示该年。
         */
        if (config.isSkipFirstDay == 1 && isSameDay(todayCalendar(), calendar)) {
            calendar.add(Calendar.YEAR, -1);
        }
        return calendar.get(Calendar.YEAR);
    }

    private static Calendar getMaxMonth(CalendarConfig config) {
        Calendar calendar = todayCalendar();
        // apply passed-in current time
        if (config != null && config.currentTs > 0) {
            calendar.setTimeInMillis(config.currentTs);
        }
        // 本月第一天为 最大月参考值
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
        if (config != null) { // 根据配置修改最大月参考值
            calendar.add(Calendar.MONTH, config.monthDelta);
        }

        /**
         * 今天为本月的第一天时，由于该月第一天还没过完，没有数据，导致该月也没数据，故不显示该月。
         * 如果今天正好是最大月的1号，则最大月减一月
         */
        if (config.isSkipFirstDay == 1 && isSameDay(todayCalendar(), calendar)
                && calendar.get(Calendar.DAY_OF_MONTH) == 1) {
            calendar.add(Calendar.MONTH, -1);
        }
        return calendar;
    }

    private static Calendar getMaxWeek(CalendarConfig config) {
        final Calendar todayCal = todayCalendar();
        Calendar calendar = todayCalendar();
        // apply passed-in current time
        if (config != null && config.currentTs > 0) {
            calendar.setTimeInMillis(config.currentTs);
        }

        /**
         * 如需调用setMinimalDaysInFirstWeek()，请先调用。否则容易出问题。
         * 例如calendar为2016年6月18日（周日）第24周，如果执行完setFirstDayOfWeek/set(Calendar.DAY_OF_WEEK, WEEK_FIRST)
         * 再调用setMinimalDaysInFirstWeek()，则calendar为2016年6月19日（周一）第25周
         */
        calendar.setMinimalDaysInFirstWeek(7);

        // 本周第一天为 最大周参考值
        calendar.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);
        calendar.set(Calendar.DAY_OF_WEEK, WEEK_FIRST);

        // String $date = calendar.getTime().toLocaleString();
        /**
         * 接上条注释，兜底方案：最大周是基于今天算出来的，算出来的最大周周一在今天之后，则将其减一
         */
        if (todayCal.before(calendar) && !isSameDay(todayCal, calendar)) {
            calendar.add(Calendar.WEEK_OF_YEAR, -1);
        }

        if (config != null) { // 根据配置修改最大周参考值
            calendar.add(Calendar.WEEK_OF_YEAR, config.weekDelta);
        }

        /**
         * 今天为本周的第一天时，由于该周第一天还没过完，没有数据，导致该周也没数据，故不显示该周。
         * 如果今天和最大周的周一是同一天，则最大周减一周
         */
        if (config.isSkipFirstDay == 1 && isSameDay(todayCal, calendar)
                && calendar.get(Calendar.DAY_OF_WEEK) == Calendar.MONDAY) {
            calendar.add(Calendar.WEEK_OF_YEAR, -1);
        }

        return calendar;
    }

    private static Calendar getMaxDay(CalendarConfig config) {
        Calendar calendar = todayCalendar();
        // apply passed-in current time
        if (config != null && config.currentTs > 0) {
            calendar.setTimeInMillis(config.currentTs);
        }

        if (config != null) { // 根据配置修改最大天参考值
            calendar.add(Calendar.DAY_OF_MONTH, config.singleDayDelta);
        }
        return calendar;
    }

    public static GroupDateModel today() {
        return GroupDateModel.from(todayCalendar());
    }

    public static Calendar todayCalendar() {
            Calendar calendar = getCalendarInstance();
        // todo inject in clock
//            calendar.setTime(new Date(AppConfig.get().currentTimeMillis()));
        calendar.setTimeInMillis(CalendarPickerHelper.getInstance().getTimeClock().currentTimeMillis());
//            calendar.set(Calendar.HOUR_OF_DAY, calendar.getMinimum(Calendar.HOUR_OF_DAY));
//            calendar.set(Calendar.MINUTE, calendar.getMinimum(Calendar.MINUTE));
//            calendar.set(Calendar.SECOND, calendar.getMinimum(Calendar.SECOND));
//            calendar.set(Calendar.MILLISECOND, calendar.getMinimum(Calendar.MILLISECOND));

        return calendar;
    }

    public static Calendar getCalendarInstance() {
        Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone(TIMEZONE));
        return calendar;
    }

    public static GroupDateModel getNextDate(CalendarConfig config, GroupDateModel current) {
        if (current == null) {
            return null;
        }
        LogUtil.d(TAG, "getNextDate/in current:" + current);
        GroupDateModel result = null;
        int type = current.type;
        switch (type) {
            case DateUnit.TYPE_DAY:
                result = getNextDay(config, current);
                break;
            case DateUnit.TYPE_MONTH:
                result = getNextMonth(config, current);
                break;
            case DateUnit.TYPE_WEEK:
                result = getNextWeek(config, current);
                break;
            case DateUnit.TYPE_YEAR:
                result = getNextYear(config, current);
                break;
            default:
                break;
        }
        LogUtil.d(TAG, "getNextDate/out current:" + current + " next:" + result);
        return result;
    }

    public static GroupDateModel getPreviousDate(CalendarConfig config, GroupDateModel current) {
        if (current == null) {
            return null;
        }
        GroupDateModel result = null;
        int type = current.type;
        switch (type) {
            case DateUnit.TYPE_DAY:
                result = getPreviousDay(config, current);
                break;
            case DateUnit.TYPE_MONTH:
                result = getPreviousMonth(config, current);
                break;
            case DateUnit.TYPE_WEEK:
                result = getPreviousWeek(config, current);
                break;
            case DateUnit.TYPE_YEAR:
                result = getPreviousYear(config, current);
                break;
            default:
                break;
        }
        LogUtil.d(TAG, "getPreviousDate/out current + " + current + " previous:" + result);
        return result;
    }

    private static GroupDateModel getNextYear(CalendarConfig config, GroupDateModel model) {
        if (getMaxYear(config) > model.start.year) {
            GroupDateModel result = new GroupDateModel();
            result.type = model.type;

            result.start = new DateModel();
            result.start.year = model.start.year + 1;
            result.start.month = model.start.month;
            result.start.day = model.start.day;

            result.end = new DateModel();
            result.end.year = model.end.year + 1;
            result.end.month = model.end.month;
            result.end.day = model.end.day;

            return result;
        }
        return null;
    }

    private static GroupDateModel getPreviousYear(CalendarConfig config, GroupDateModel model) {
        int minYear = DEFAULT_MIN_YEAR;
        try {
            String dateStr = config.startDate;
            minYear = Integer.valueOf(dateStr.substring(0, 4));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        LogUtil.d(TAG, "getPreviousYear/in min:" + minYear + " config:" + config);
        if (minYear < model.start.year) {
            GroupDateModel result = new GroupDateModel();
            result.type = model.type;

            result.start = new DateModel();
            result.start.year = model.start.year - 1;
            result.start.month = model.start.month;
            result.start.day = model.start.day;

            result.end = new DateModel();
            result.end.year = model.end.year - 1;
            result.end.month = model.end.month;
            result.end.day = model.end.day;
            return result;
        }
        return null;
    }

    public static GroupDateModel getNextMonth(CalendarConfig config, GroupDateModel model) {
        Date date = model.start.toDate();
        Calendar calendar = getCalendarInstance();
        calendar.setTime(date);

        calendar.add(Calendar.MONTH, 1);

        Calendar maxMonth = getMaxMonth(config);
        if (calendar.before(maxMonth) || isSameMonth(calendar, maxMonth)) {
            GroupDateModel result = new GroupDateModel();
            result.type = model.type;

            result.start = new DateModel();
            result.start.year = calendar.get(Calendar.YEAR);
            result.start.month = calendar.get(Calendar.MONTH) + 1;
            result.start.day = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);

            result.end = new DateModel();
            result.end.year = calendar.get(Calendar.YEAR);
            result.end.month = calendar.get(Calendar.MONTH) + 1;
            result.end.day = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

            return result;
        }

        return null;
    }

    public static GroupDateModel getPreviousMonth(CalendarConfig config, GroupDateModel model) {
        // get min
        Calendar minCal = DEFAULT_MIN_MONTH;
        if (config != null) {
            try {
                int year = Integer.valueOf(config.startDate.substring(0, 4));
                int month = Integer.valueOf(config.startDate.substring(4, 6));
                int day = Integer.valueOf(config.startDate.substring(6, 8));
                minCal = getCalendarInstance();
                minCal.set(year, month - 1, day);
                minCal.set(Calendar.DAY_OF_MONTH, minCal.getActualMinimum(Calendar.DAY_OF_MONTH));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            } catch (NullPointerException e) {
                e.printStackTrace();
            }
            LogUtil.d(TAG, "getPreviousMonth/in min:" + config.startDate);
        }

        Date date = model.start.toDate();
        Calendar calendar = getCalendarInstance();
        calendar.setTime(date);

        calendar.add(Calendar.MONTH, -1);

        if (minCal.before(calendar) || isSameMonth(calendar, minCal)) {
            GroupDateModel result = new GroupDateModel();
            result.type = model.type;

            result.start = new DateModel();
            result.start.year = calendar.get(Calendar.YEAR);
            result.start.month = calendar.get(Calendar.MONTH) + 1;
            result.start.day = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);

            result.end = new DateModel();
            result.end.year = calendar.get(Calendar.YEAR);
            result.end.month = calendar.get(Calendar.MONTH) + 1;
            result.end.day = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

            return result;
        }

        return null;
    }

    public static GroupDateModel getNextWeek(CalendarConfig config, GroupDateModel model) {
        LogUtil.d(TAG, "getNextWeek/in model:" + model + " week:" + model.start.week);
        Date date = model.start.toDate();
        Calendar calendar = getCalendarInstance();
        calendar.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);
        calendar.setMinimalDaysInFirstWeek(7);  //设置每周最少为7天
        calendar.setTime(date);

//        LogUtil.d("wpf", "getNextWeek/in cal1:" + calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH) + 1)
//                + "-" + (calendar.get(Calendar.DAY_OF_MONTH)) + ",w" + calendar.get(Calendar.WEEK_OF_YEAR));

        calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        calendar.add(Calendar.WEEK_OF_YEAR, 1);
//
//        LogUtil.d("wpf", "getNextWeek/in cal2:" + calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH) + 1)
//            + "-" + calendar.get(Calendar.DAY_OF_MONTH) + ",w" + calendar.get(Calendar.WEEK_OF_YEAR));

        Calendar maxWeek = getMaxWeek(config);

//        LogUtil.d("wpf", "getNextWeek/in cal3:" + maxWeek.get(Calendar.YEAR) + "-" + (maxWeek.get(Calendar.MONTH) + 1)
//                + "-" + maxWeek.get(Calendar.DAY_OF_MONTH) + ",w" + maxWeek.get(Calendar.WEEK_OF_YEAR));
//
//        LogUtil.d("wpf", "getNextWeek/in isBefore:" + calendar.before(maxWeek) + "  same week：" + isSameWeek(calendar, maxWeek));

        if (calendar.before(maxWeek) || isSameWeek(calendar, maxWeek)) {
            GroupDateModel result = new GroupDateModel();
            result.type = model.type;

            result.start = new DateModel();
            result.start.year = calendar.get(Calendar.YEAR);
            result.start.month = calendar.get(Calendar.MONTH) + 1;
            result.start.week = calendar.get(Calendar.WEEK_OF_YEAR);
            result.start.weekYear = result.start.year;
            result.start.day = calendar.get(Calendar.DAY_OF_MONTH);

            calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
            result.end = new DateModel();
            result.end.year = calendar.get(Calendar.YEAR);
            result.end.month = calendar.get(Calendar.MONTH) + 1;
            result.end.week = calendar.get(Calendar.WEEK_OF_YEAR);
            result.end.weekYear = result.start.weekYear;
            result.end.day = calendar.get(Calendar.DAY_OF_MONTH);
            return result;
        }
        return null;
    }

    public static GroupDateModel getPreviousWeek(CalendarConfig config, GroupDateModel model) {
        Calendar minWeek = DEFAULT_MIN_WEEK;
        if (config != null) {
            try {
                int year = Integer.valueOf(config.startDate.substring(0, 4));
                int month = Integer.valueOf(config.startDate.substring(4, 6));
                int day = Integer.valueOf(config.startDate.substring(6, 8));
                minWeek = getCalendarInstance();
                minWeek.set(year, month - 1, day);

//                Log.d(TAG,
//                        "getPreviousWeek/11111 min:" + config.startDate + " biz:" + bizType + " minWeek:" + minWeek.get(
//                                Calendar.YEAR) + "-" + (minWeek.get(Calendar.MONTH) + 1) + "-" + (minWeek.get(
//                                Calendar.DAY_OF_MONTH)) + " w" + minWeek.get(Calendar.WEEK_OF_YEAR));
//                int $yyyy = minWeek.get(Calendar.YEAR);
//                int $mmmm = minWeek.get(Calendar.MONTH);
//                int $dddd = minWeek.get(Calendar.DAY_OF_MONTH);
//                int $wwww = minWeek.get(Calendar.WEEK_OF_YEAR);

                minWeek.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);
//                Log.d(TAG, "getPreviousWeek/22222 min:" + config.startDate + " biz:" + bizType + " minWeek:"
//                        + minWeek.get(Calendar.YEAR) + "-" + (minWeek.get(Calendar.MONTH) + 1) + "-" + (minWeek.get(Calendar.DAY_OF_MONTH))
//                        + " w" + minWeek.get(Calendar.WEEK_OF_YEAR));
//                $yyyy = minWeek.get(Calendar.YEAR);
//                $mmmm = minWeek.get(Calendar.MONTH);
//                $dddd = minWeek.get(Calendar.DAY_OF_MONTH);
//                $wwww = minWeek.get(Calendar.WEEK_OF_YEAR);

                minWeek.setMinimalDaysInFirstWeek(7);
                minWeek.set(Calendar.WEEK_OF_YEAR, minWeek.getActualMinimum(Calendar.WEEK_OF_YEAR));
//                Log.d(TAG, "getPreviousWeek/33333 min:" + minWeek.getActualMinimum(Calendar.WEEK_OF_YEAR) + " biz:" + bizType + " minWeek:"
//                        + minWeek.get(Calendar.YEAR) + "-" + (minWeek.get(Calendar.MONTH) + 1) + "-" + (minWeek.get(Calendar.DAY_OF_MONTH))
//                        + " w" + minWeek.get(Calendar.WEEK_OF_YEAR));
                int $yyyy = minWeek.get(Calendar.YEAR);
                int $mmmm = minWeek.get(Calendar.MONTH);
                int $dddd = minWeek.get(Calendar.DAY_OF_MONTH);
                int $wwww = minWeek.get(Calendar.WEEK_OF_YEAR);

                minWeek.set(Calendar.DAY_OF_WEEK, WEEK_FIRST);

            } catch (NumberFormatException e) {
                e.printStackTrace();
            } catch (NullPointerException e) {
                e.printStackTrace();
            }
            LogUtil.d(TAG, "getPreviousWeek/in min:" + config.startDate + " minWeek:"
            + minWeek.get(Calendar.YEAR) + "-" + (minWeek.get(Calendar.MONTH) + 1) + "-" + (minWeek.get(
                    Calendar.DAY_OF_MONTH))
            + " w" + minWeek.get(Calendar.WEEK_OF_YEAR));
        }

        Date date = model.start.toDate();
        Calendar calendar = getCalendarInstance();
        calendar.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);
        calendar.setMinimalDaysInFirstWeek(7);  //设置每周最少为7天
        calendar.setTime(date);

        calendar.set(Calendar.DAY_OF_WEEK, WEEK_FIRST);
        calendar.add(Calendar.WEEK_OF_YEAR, -1);

        if (minWeek.before(calendar) || isSameWeek(calendar, minWeek)) {
            GroupDateModel result = new GroupDateModel();
            result.type = model.type;

            result.start = new DateModel();
            result.start.year = calendar.get(Calendar.YEAR);
            result.start.month = calendar.get(Calendar.MONTH) + 1;
            result.start.week = calendar.get(Calendar.WEEK_OF_YEAR);
            result.start.weekYear = result.start.year;
            result.start.day = calendar.get(Calendar.DAY_OF_MONTH);

            calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
            result.end = new DateModel();
            result.end.year = calendar.get(Calendar.YEAR);
            result.end.month = calendar.get(Calendar.MONTH) + 1;
            result.end.week = calendar.get(Calendar.WEEK_OF_YEAR);
            result.end.weekYear = result.start.weekYear;
            result.end.day = calendar.get(Calendar.DAY_OF_MONTH);

            return result;
        }
        return null;
    }

    public static GroupDateModel getNextDay(CalendarConfig config, GroupDateModel model) {
        Date date = model.start.toDate();
        Calendar calendar = getCalendarInstance();
        calendar.setTime(date);

        calendar.add(Calendar.DAY_OF_MONTH, 1);

        Calendar maxDay = getMaxDay(config);
        LogUtil.d(TAG, "getNextDay/in delta:" + config.singleDayDelta + " max:" + maxDay.get(
                Calendar.DAY_OF_MONTH));

        if (calendar.before(maxDay) || isSameDay(calendar, maxDay)) {
            GroupDateModel result = new GroupDateModel();
            result.type = model.type;

            result.start = new DateModel();
            result.start.year = calendar.get(Calendar.YEAR);
            result.start.month = calendar.get(Calendar.MONTH) + 1;
            result.start.day = calendar.get(Calendar.DAY_OF_MONTH);

            result.end = new DateModel();
            result.end.year = calendar.get(Calendar.YEAR);
            result.end.month = calendar.get(Calendar.MONTH) + 1;
            result.end.day = calendar.get(Calendar.DAY_OF_MONTH);

            return result;
        }

        return null;
    }

    public static GroupDateModel getPreviousDay(CalendarConfig config, GroupDateModel model) {
        // get min
        Calendar minDay = DEFAULT_MIN_DAY;
        if (config != null) {
            try {
                int year = Integer.valueOf(config.startDate.substring(0, 4));
                int month = Integer.valueOf(config.startDate.substring(4, 6));
                int day = Integer.valueOf(config.startDate.substring(6, 8));
                minDay = getCalendarInstance();
                minDay.set(year, month - 1, day);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            } catch (NullPointerException e) {
                e.printStackTrace();
            }
            LogUtil.d(TAG, "getPreviousDay/in min:" + config.startDate);
        }

        Date date = model.start.toDate();
        Calendar calendar = getCalendarInstance();
        calendar.setTime(date);

        calendar.add(Calendar.DAY_OF_MONTH, -1);

        if (minDay.before(calendar) || isSameDay(calendar, minDay)) {
            GroupDateModel result = new GroupDateModel();
            result.type = model.type;

            result.start = new DateModel();
            result.start.year = calendar.get(Calendar.YEAR);
            result.start.month = calendar.get(Calendar.MONTH) + 1;
            result.start.day = calendar.get(Calendar.DAY_OF_MONTH);

            result.end = new DateModel();
            result.end.year = calendar.get(Calendar.YEAR);
            result.end.month = calendar.get(Calendar.MONTH) + 1;
            result.end.day = calendar.get(Calendar.DAY_OF_MONTH);

            return result;
        }

        return null;
    }

    public static boolean isSameDay(Calendar cal1, Calendar cal2) {
        if (cal1 == null || cal2 == null) {
            return false;
        }
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) && cal1.get(Calendar.MONTH) == cal2.get(
                Calendar.MONTH)
                && cal1.get(Calendar.DAY_OF_MONTH) == cal2.get(Calendar.DAY_OF_MONTH);
    }

    public static boolean isSameWeek(Calendar cal1, Calendar cal2) {
        if (cal1 == null || cal2 == null) {
            return false;
        }
        cal1.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);
        cal2.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);
        cal1.setMinimalDaysInFirstWeek(7);
        cal2.setMinimalDaysInFirstWeek(7);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) && cal1.get(Calendar.WEEK_OF_YEAR) == cal2.get(
                Calendar.WEEK_OF_YEAR);
    }

    public static boolean isSameWeek(GroupDateModel cal1, GroupDateModel cal2) {
        if (cal1 == null || cal2 == null) {
            return false;
        }
        return cal1.start.year == cal2.start.year && cal1.start.week == cal2.start.week;
    }

    public static boolean isSameMonth(GroupDateModel cal1, GroupDateModel cal2) {
        if (cal1 == null || cal2 == null) {
            return false;
        }
        return cal1.start.year == cal2.start.year && cal1.start.month == cal2.start.month;
    }

    public static boolean isSameMonth(Calendar cal1, Calendar cal2) {
        if (cal1 == null || cal2 == null) {
            return false;
        }
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) && cal1.get(Calendar.MONTH) == cal2.get(
                Calendar.MONTH);
    }

    public static boolean isSameYear(Calendar cal1, Calendar cal2) {
        if (cal1 == null || cal2 == null) {
            return false;
        }
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR);
    }

    public static boolean isSameYear(GroupDateModel cal1, GroupDateModel cal2) {
        if (cal1 == null || cal2 == null) {
            return false;
        }
        return cal1.start.year == cal2.start.year;
    }

    public static boolean isBefore(GroupDateModel cal1, GroupDateModel cal2) {
        if (cal1 == null || cal2 == null) {
            return false;
        }
        // cal1的结束时间比cal2的开始时间早，就算早
        Date date1 = cal1.end.toDate();
        Date date2 = cal2.start.toDate();
        return date1.before(date2);
    }

    public static boolean isToday(GroupDateModel model) {
        if (model == null) {
            return false;
        }
        Date date = model.start.toDate();
        Calendar calendar = getCalendarInstance();
        calendar.setTime(date);
        return isSameDay(calendar, todayCalendar());
    }

    public static boolean containsToday(GroupDateModel model) {
        if (model == null) {
            return false;
        }

        Date start = model.start.toDate();
        Date end = model.end.toDate();
        Calendar startCal = getCalendarInstance();
        startCal.setTime(start);
        startCal.set(Calendar.HOUR_OF_DAY, 0);
        startCal.set(Calendar.MINUTE, 0);
        startCal.set(Calendar.SECOND, 0);
        startCal.set(Calendar.MILLISECOND, 0);
        long startTs = startCal.getTimeInMillis();

        Calendar endCal = getCalendarInstance();
        endCal.setTime(end);
        endCal.set(Calendar.HOUR_OF_DAY, 0);
        endCal.set(Calendar.MINUTE, 0);
        endCal.set(Calendar.SECOND, 0);
        endCal.set(Calendar.MILLISECOND, 0);
        long endTs = endCal.getTimeInMillis();

        Calendar calendar = getCalendarInstance();
        calendar.setTimeInMillis(todayCalendar().getTimeInMillis());
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        long today = calendar.getTimeInMillis();

        return (today >= startTs && today <= endTs);
    }

    public static int getDaysInterval(DateModel startModel, DateModel endModel) {
        if (startModel == null || endModel == null) {
            return 0;
        }

        Date start = startModel.toDate();
        Date end = endModel.toDate();

        return getDaysInterval(start, end);
    }

    public static int getDaysInterval(Date start, Date end) {
        Calendar startCal = getCalendarInstance();
        startCal.setTime(start);
        startCal.set(Calendar.HOUR_OF_DAY, 0);
        startCal.set(Calendar.MINUTE, 0);
        startCal.set(Calendar.SECOND, 0);

        Calendar endCal = getCalendarInstance();
        endCal.setTime(end);
        endCal.set(Calendar.HOUR_OF_DAY, 0);
        endCal.set(Calendar.MINUTE, 0);
        endCal.set(Calendar.SECOND, 0);

        long startMili = startCal.getTimeInMillis();
        long endMili = endCal.getTimeInMillis();

        long interval = endMili - startMili;
        int days = (int) (interval / 1000 / 3600/ 24);

        return days;
    }

    public static GroupDateModel getDaysByDelta(DateModel startModel, int delta) {
        if (startModel == null) {
            return null;
        }

        Date start = startModel.toDate();
        Calendar startCal = getCalendarInstance();
        startCal.setTime(start);
        startCal.set(Calendar.HOUR_OF_DAY, 0);
        startCal.set(Calendar.MINUTE, 0);
        startCal.set(Calendar.SECOND, 0);

        startCal.add(Calendar.DAY_OF_MONTH, delta);

        return GroupDateModel.from(startCal);
    }

    /**
     * 1-7 ，Sunday为1
     * @param date
     * @return
     */
    public static int getDayOfWeek(DateModel date) {
        if (date == null) {
            return -1;
        }
        Date myDate = date.toDate();
        Calendar calendar = getCalendarInstance();
        calendar.setTime(myDate);

        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        return dayOfWeek;
    }

    public static String getDayOfWeekString(DateModel date) {
        int dayOfWeek = getDayOfWeek(date);
        String text = null;
        switch (dayOfWeek) {
            case Calendar.SUNDAY:
                text = "日";
                break;
            case Calendar.MONDAY:
                text = "一";
                break;
            case Calendar.TUESDAY:
                text = "二";
                break;
            case Calendar.WEDNESDAY:
                text = "三";
                break;
            case Calendar.THURSDAY:
                text = "四";
                break;
            case Calendar.FRIDAY:
                text = "五";
                break;
            case Calendar.SATURDAY:
                text = "六";
                break;
        }
        return text;
    }

    public static GroupDateModel getCurrent(int type) {
        GroupDateModel model = null;
        Calendar calendar = todayCalendar();
        switch (type) {
            case DateUnit.TYPE_DAY:
                model = new GroupDateModel();
                model.type = type;
                model.start = DateModel.from(calendar);
                model.end = DateModel.from(calendar);
                break;
            case DateUnit.TYPE_MONTH:
                model = new GroupDateModel();
                model.type = type;
                calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
                model.start = DateModel.from(calendar);

                calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
                model.end = DateModel.from(calendar);
                break;
            case DateUnit.TYPE_WEEK:
                model = new GroupDateModel();
                model.type = type;
                calendar.setFirstDayOfWeek(FIRST_DAY_OF_WEEK);
                calendar.setMinimalDaysInFirstWeek(MIN_WEEK_DAYS);

                calendar.set(Calendar.DAY_OF_WEEK, WEEK_FIRST);
                int weekStartYear = calendar.get(Calendar.YEAR);
                model.start = DateModel.from(calendar);
                model.start.weekYear = calendar.get(Calendar.YEAR);
                model.start.week = calendar.get(Calendar.WEEK_OF_YEAR);

                calendar.set(Calendar.DAY_OF_WEEK, WEEK_END);
                model.end = DateModel.from(calendar);
                /**
                 * 某些年的前几天属于上一年的最后一周，如2017年1月1日属于2016年的第52周，2017.1.1时currentWeek为52，
                 * 和2017年拼起来，会导致把2017年1-52周的数据都展示出来。
                 * 方案：
                 * 如果某天属于该年的前7天内，则判断该天的WEEK_OF_MONTH字段是否大于0，小于0表示该天不属于该月的周。
                 */
                model.end.weekYear = weekStartYear;
                model.end.week = calendar.get(Calendar.WEEK_OF_YEAR);
                break;
            case DateUnit.TYPE_YEAR:
                model = new GroupDateModel();
                model.type = type;
                calendar.set(Calendar.DAY_OF_YEAR, calendar.getActualMinimum(Calendar.DAY_OF_YEAR));
                model.start = DateModel.from(calendar);

                calendar.set(Calendar.DAY_OF_YEAR, calendar.getActualMaximum(Calendar.DAY_OF_YEAR));
                model.end = DateModel.from(calendar);
                break;
            default:
                break;
        }

        return model;
    }

}
