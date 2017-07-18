package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import org.weex.plugin.weexplugincalendar.R;
import org.weex.plugin.weexplugincalendar.calendar.CalendarOptions;
import org.weex.plugin.weexplugincalendar.calendar.CalendarPickerHelper;
import org.weex.plugin.weexplugincalendar.calendar.SelectMode;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarHeader;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;

/**
 * Created by pengfei on 17/2/27.
 */

public class BaseCalendarPageFragment extends BaseFragment {

    protected View rangeConfirmContainer;

    protected TextView startDateView;

    protected TextView endDateView;

    protected TextView confirmBtn;

    protected TextView staticToast;

    protected CalendarOptions options;

    protected int maxUnit;

    protected int mode;

    public BaseCalendarPageFragment() {
        super();
        if (getArguments() != null) {
            options = getArguments().getParcelable(CalendarPickerHelper.EXTRA_OPTION);
        } else if (getActivity() != null && getActivity().getIntent() != null){
            options = getActivity().getIntent().getParcelableExtra(CalendarPickerHelper.EXTRA_OPTION);
        }

    }

    @Override
    public View onCreateContentView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        return null;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        if (getArguments() != null) {
            options = getArguments().getParcelable(CalendarPickerHelper.EXTRA_OPTION);
        } else if (getActivity() != null && getActivity().getIntent() != null){
            options = getActivity().getIntent().getParcelableExtra(CalendarPickerHelper.EXTRA_OPTION);
        }

        // range select ui
        rangeConfirmContainer = view.findViewById(R.id.container_calendar_multi_picker);
        startDateView = (TextView) view.findViewById(R.id.tv_calendar_multi_picker_start_value);
        endDateView = (TextView) view.findViewById(R.id.tv_calendar_multi_picker_end_value);
        confirmBtn = (TextView) view.findViewById(R.id.tv_calendar_multi_picker_confirm);
        staticToast = (TextView) view.findViewById(R.id.tv_calendar_select_toast);
    }

    @Override
    public void setArguments(Bundle args) {
        super.setArguments(args);
        options = args.getParcelable(CalendarPickerHelper.EXTRA_OPTION);
    }

//    @Override
//    protected View createTitleBar(LayoutInflater inflater) {
//        // no title bar
//        return null;
//    }

    protected void notifyListener(GroupDateModel model) {
        if (model != null && CalendarPickerHelper.getInstance().getResultListener() != null) {
            CalendarPickerHelper.getInstance().getResultListener().onResult(model);
            CalendarPickerHelper.getInstance().setResultListener(null);
            getActivity().finish();
            CalendarPickerHelper.getInstance().setStarted(false);
        }

    }

    protected int findModeForType(int type) {
        mode = SelectMode.SINGLE;
        for (CalendarHeader header: options.headers) {
            if (header != null && header.type == type) {
                mode = header.mode;
                maxUnit = header.maxUnit;
                break;
            }
        }
        return mode;
    }

}
