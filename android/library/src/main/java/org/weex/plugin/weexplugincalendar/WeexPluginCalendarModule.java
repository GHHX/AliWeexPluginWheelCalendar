package org.weex.plugin.weexplugincalendar;

import com.alibaba.weex.plugin.annotation.WeexModule;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;
import com.taobao.weex.common.WXModule;

import org.weex.plugin.weexplugincalendar.calendar.CalendarOptions;
import org.weex.plugin.weexplugincalendar.calendar.CalendarPickerHelper;
import org.weex.plugin.weexplugincalendar.calendar.ICalendarAWXModule;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarConfig;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;
import org.weex.plugin.weexplugincalendar.calendar.util.LogUtil;

import java.io.Serializable;

@WeexModule(name = "weexPluginCalendar")
public class WeexPluginCalendarModule extends WXModule implements ICalendarAWXModule {

    private static final String TAG = "CALENDAR";

    //sync ret example
    @JSMethod
    public String syncRet(String param) {
        return param;
    }

    //async ret example
    @JSMethod
    public void asyncRet(String param, JSCallback callback) {
        callback.invoke(param);
    }

    @Override
    @JSMethod
    public void startCalendar(CalendarOptions paramJson, final JSCallback callbackOk, final JSCallback callbackCancel) {
//        List<CalendarHeader> headers = JsonUtil.parseArray(headersJson, CalendarHeader.class);
//        CalendarHeader [] headerArray = headers.toArray(new CalendarHeader [headers.size()]);
//
//        GroupDateModel model = JsonUtil.parseObject(dateJson, GroupDateModel.class);

//        CalendarOptions options = JsonUtil.parseObject(paramJson, CalendarOptions.class);
        CalendarOptions options = paramJson;
        if (options == null) {
            return;
        }

        CalendarPickerHelper.getInstance().startPicker(mWXSDKInstance.getContext(), options,
                new CalendarPickerHelper.OnResultListener() {
            @Override
            public void onResult(GroupDateModel select) {
                if (callbackOk != null) {
                    callbackOk.invoke(select);
                }
            }

            @Override
            public void onCancel() {
                if (callbackCancel != null) {
                    callbackCancel.invoke(null);
                }
            }
        });
    }

    @Override
    @JSMethod
    public void getNextDate(ParamModel dateJson, JSCallback callback) {
        LogUtil.d(TAG, "getNextDate:" + dateJson);
        ParamModel paramModel = dateJson; //JsonUtil.parseObject(dateJson, ParamModel.class);
        if (paramModel == null) {
            if (callback != null) {
                callback.invoke(new GroupDateModel());
            }
            return;
        }
        if (paramModel.config == null) {
//            paramModel.config = CalendarPickerHelper.parseConfigFromBizType(paramModel.bizType);
        }

        GroupDateModel next = null;
        if (paramModel != null && paramModel.currentModel != null && paramModel.currentModel.start != null) {
            next = CalendarUtil.getNextDate(paramModel.config, paramModel.currentModel);
        }

        if (next == null) { // weex无法解析空对象，需要new一个空对象
            next = new GroupDateModel();
        }
        if (callback != null) {
            callback.invoke(next);
        }
    }

    @Override
    @JSMethod
    public void getPrevDate(ParamModel dateJson, JSCallback callback) {
        LogUtil.d(TAG, "getPrevDate:" + dateJson);
        ParamModel paramModel = dateJson;// JsonUtil.parseObject(dateJson, ParamModel.class);
        if (paramModel == null) {
            if (callback != null) {
                callback.invoke(new GroupDateModel());
            }
            return;
        }
        if (paramModel.config == null) {
//            paramModel.config = CalendarPickerHelper.parseConfigFromBizType(paramModel.bizType);
        }

        GroupDateModel previous = null;
        if (paramModel != null && paramModel.currentModel != null && paramModel.currentModel.start != null) {
            previous = CalendarUtil.getPreviousDate(paramModel.config, paramModel.currentModel);
        }

        if (previous == null) { // weex无法解析空对象，需要new一个空对象
            previous = new GroupDateModel();
        }
        if (callback != null) {
            callback.invoke(previous);
        }
    }

    @Override
    @JSMethod
    public void getCurrent(GetCurrentParam dateJson, JSCallback callback) {
        LogUtil.d(TAG, "getCurrent:" + dateJson);
        GetCurrentParam param = dateJson;// JsonUtil.parseObject(dateJson, GetCurrentParam.class);
        if (param == null) {
            if (callback != null) {
                callback.invoke(new GroupDateModel());
            }
            return;
        }
        GroupDateModel result = CalendarUtil.getCurrent(param.type);

        if (result == null) {
            result = new GroupDateModel();
        }
        if (callback != null) {
            callback.invoke(result);
        }

    }

    public static class ParamModel implements Serializable {
        public GroupDateModel currentModel;
        public CalendarConfig config;
    }

    public static class GetCurrentParam implements Serializable {
        public int type;
    }
}
