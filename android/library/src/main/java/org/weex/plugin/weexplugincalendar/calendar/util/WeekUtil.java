package org.weex.plugin.weexplugincalendar.calendar.util;

import org.weex.plugin.weexplugincalendar.calendar.model.DateModel;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by pengfei on 17/2/22.
 */

public class WeekUtil {


    public static List<GroupDateModel> getWeeksByYear(final int year) {
        return getWeeksByYear(year, -1);
    }

    /**
     * 返回指定年度的所有周。List中包含的是String[2]对象<br>
     * string[0]本周的开始日期,string[1]是本周的结束日期。<br>
     * 日期的格式为yyyy-MM-dd。<br>
     * 每年的第一个周，必须包含星期一且是完整的七天。<br>
     * 例如：2009年的第一个周开始日期为2009-01-05，结束日期为2009-01-11。 <br>
     * 星期一在哪一年，那么包含这个星期的周就是哪一年的周。<br>
     * 例如：2008-12-29是星期一，2009-01-04是星期日，哪么这个周就是2008年度的最后一个周。<br>
     *
     * @param year 格式 yyyy  ，必须大于1900年度 小于9999年
     * @return
     */
    public static List<GroupDateModel> getWeeksByYear(final int year, int stopAt){
        if(year<1900 || year >9999){
            throw new NullPointerException("年度必须大于等于1900年小于等于9999年");
        }
        //实现思路，首先计算当年有多少个周，然后找到每个周的开始日期和结束日期

//      Calendar calendar = new GregorianCalendar();
//      // 在具有默认语言环境的默认时区内使用当前时间构造一个默认的 GregorianCalendar。
//      calendar.setFirstDayOfWeek(Calendar.MONDAY); //设置每周的第一天为星期一
//      calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); //每周从周一开始
//      上面两句代码配合，才能实现，每年度的第一个周，是包含第一个星期一的那个周。
//      calendar.setMinimalDaysInFirstWeek(7);  //设置每周最少为7天
//      calendar.set(Calendar.YEAR, year); // 设置年度为指定的年

//      //首先计算当年有多少个周,每年都至少有52个周，个别年度有53个周

        int weeks = getWeekNumByYear(year);
        if (stopAt > 0) {
            weeks = stopAt;
        }
        List<GroupDateModel> result = new ArrayList<>(weeks);
        for(int i=1;i<=weeks;i++){
            DateModel start = getYearWeekFirstDay(year,i);
            start.weekYear = year;
            DateModel end = getYearWeekEndDay (year,i);
            end.weekYear = year;
//或者使用下面的代码，不过发现效率更低
//          tempWeek[0] = getDateAdd(firstWeekDay,(i-1)*7+0);
//          tempWeek[1] = getDateAdd(firstWeekDay,(i-1)*7+6);
            GroupDateModel model = new GroupDateModel();
            model.start = start;
            model.end = end;
            result.add(model);
        }
        return result;
    }

    /**
     * 计算指定年度共有多少个周。
     * @param year 格式 yyyy  ，必须大于1900年度 小于9999年
     * @return
     */
    public static int getWeekNumByYear(final int year){
        if(year<1900 || year >9999){
            throw new NullPointerException("年度必须大于等于1900年小于等于9999年");
        }
        int result = 52;//每年至少有52个周 ，最多有53个周。
        DateModel data = getYearWeekFirstDay(year,53);
        if(data.year == year){ //判断年度是否相符，如果相符说明有53个周。
            result = 53;
        }
        return result;
    }


    /**
     * 计算某年某周的开始日期
     * @param yearNum 格式 yyyy  ，必须大于1900年度 小于9999年
     * @param weekNum 1到52或者53
     * @return 日期，格式为yyyy-MM-dd
     */
    public static DateModel getYearWeekFirstDay(int yearNum,int weekNum)  {
        if(yearNum<1900 || yearNum >9999){
            throw new NullPointerException("年度必须大于等于1900年小于等于9999年");
        }
        Calendar cal = CalendarUtil.getCalendarInstance();
        cal.setFirstDayOfWeek(Calendar.MONDAY); //设置每周的第一天为星期一
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);//每周从周一开始
//       上面两句代码配合，才能实现，每年度的第一个周，是包含第一个星期一的那个周。
        cal.setMinimalDaysInFirstWeek(7);  //设置每周最少为7天
        cal.set(Calendar.YEAR, yearNum);
        cal.set(Calendar.WEEK_OF_YEAR, weekNum);

        //分别取得当前日期的年、月、日
        DateModel model = new DateModel();
        model.year = cal.get(Calendar.YEAR);
        model.month = cal.get(Calendar.MONTH) + 1;
        model.day = cal.get(Calendar.DAY_OF_MONTH);
        model.week = weekNum;

        return model;
    }

    /**
     * 计算某年某周的结束日期
     * @param yearNum 格式 yyyy  ，必须大于1900年度 小于9999年
     * @param weekNum 1到52或者53
     * @return 日期，格式为yyyy-MM-dd
     */
    public static DateModel getYearWeekEndDay(int yearNum,int weekNum)  {
        if(yearNum<1900 || yearNum >9999){
            throw new NullPointerException("年度必须大于等于1900年小于等于9999年");
        }
        Calendar cal = CalendarUtil.getCalendarInstance();
        cal.setFirstDayOfWeek(Calendar.MONDAY); //设置每周的第一天为星期一
        cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);//每周从周一开始
//       上面两句代码配合，才能实现，每年度的第一个周，是包含第一个星期一的那个周。
        cal.setMinimalDaysInFirstWeek(7);  //设置每周最少为7天
        cal.set(Calendar.YEAR, yearNum);
        cal.set(Calendar.WEEK_OF_YEAR, weekNum);

        DateModel model = new DateModel();
        model.year = cal.get(Calendar.YEAR);
        model.month = cal.get(Calendar.MONTH) + 1;
        model.day = cal.get(Calendar.DAY_OF_MONTH);
        model.week = weekNum;

        return model;
    }

    private static String getFormatDate(Date timeMili) {
        return timeMili.toLocaleString();
    }
}
