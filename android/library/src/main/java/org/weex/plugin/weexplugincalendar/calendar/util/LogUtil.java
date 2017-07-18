package org.weex.plugin.weexplugincalendar.calendar.util;

import android.util.Log;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * User: zimuo.wl Date: 14-3-17 Time: 上午11:47
 *
 * 自动标记当前类名为TAG，信息中自动添加方法名，方便调试。
 */
public class LogUtil {

    public static boolean DEBUG = true;

    public static void v(String TAG, String msg) {
        if (DEBUG) {
            Log.v(TAG, "[ " + getFileLineMethod() + " ] " + msg);
        }
    }

    public static void v(String msg) {
        if (DEBUG) {
            Log.v(_FILE_(), "[ " + getLineMethod() + " ] " + msg);
        }
    }

    public static void d(String TAG, String msg) {
        if (DEBUG) {
            Log.d(TAG, "[ " + getFileLineMethod() + " ] " + msg);
        }
    }

    public static void d(String msg) {
        if (DEBUG) {
            Log.d(_FILE_(), "[ " + getLineMethod() + " ] " + msg);
        }
    }

    public static void i(String TAG, String msg) {
        if (DEBUG) {
            Log.i(TAG, "[ " + getFileLineMethod() + " ] " + msg);
        }
    }

    public static void i(String msg) {
        if (DEBUG) {
            Log.i(_FILE_(), "[ " + getLineMethod() + " ] " + msg);
        }
    }

    public static void w(String TAG, String msg) {
        if (DEBUG) {
            Log.w(TAG, "[ " + getFileLineMethod() + " ] " + msg);
        }
    }

    public static void w(String msg) {
        if (DEBUG) {
            Log.w(_FILE_(), "[ " + getLineMethod() + " ] " + msg);
        }
    }

    public static void e(String msg) {
        if (DEBUG) {
            Log.e(_FILE_(), getLineMethod() + msg);
        }
    }

    public static void e(String TAG, String msg) {
        if (DEBUG) {
            Log.e(TAG, getLineMethod() + msg);
        }
    }

    public static void e(String TAG, Exception e) {
        if (DEBUG) {
            Log.e(TAG, getLineMethod() + e.getMessage());
        }
    }

    public static void currentMethod(){
        if (DEBUG) {
            Log.i(_FILE_(), "[method]"+"[ " + getLineMethod() + " ] "+ System.currentTimeMillis());
        }
    }
    public static void currentMethod(String str){
        if (DEBUG) {
            Log.i(_FILE_(), "[method]"+"[ " + getLineMethod() + " ] "+ System.currentTimeMillis()+" "+str);
        }
    }

    private static String getFileLineMethod() {
        StackTraceElement traceElement = ((new Exception()).getStackTrace())[2];
        StringBuffer toStringBuffer = new StringBuffer()
                .append(traceElement.getFileName()).append(" | ")
                .append(traceElement.getLineNumber()).append(" | ")
                .append(traceElement.getMethodName());//.append("]");
        return toStringBuffer.toString();
    }

    private static String getLineMethod() {
        StackTraceElement traceElement = ((new Exception()).getStackTrace())[2];
        StringBuffer toStringBuffer = new StringBuffer()
                .append(traceElement.getLineNumber()).append(" | ")
                .append(traceElement.getMethodName());//.append("]");
        return toStringBuffer.toString();
    }

    private static String _FILE_() {
        StackTraceElement traceElement = ((new Exception()).getStackTrace())[2];
        return traceElement.getFileName();
    }

    private static String _FUNC_() {
        StackTraceElement traceElement = ((new Exception()).getStackTrace())[1];
        return traceElement.getMethodName();
    }

    private static int _LINE_() {
        StackTraceElement traceElement = ((new Exception()).getStackTrace())[1];
        return traceElement.getLineNumber();
    }

    private static String _TIME_() {
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS", Locale.CHINA);
        return sdf.format(now);
    }

    public static void printLongString(String tag, String str) {
        if (DEBUG) {
            int maxLogSize = 1000;

            for (int i = 0; i <= str.length() / maxLogSize; i++) {
                int start = i * maxLogSize;
                int end = (i + 1) * maxLogSize;
                end = end > str.length() ? str.length() : end;
                Log.v(tag, "[" + i + "]:" + str.substring(start, end));
            }
        }
    }
}
