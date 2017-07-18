package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.alipictures.cozyadapter.sdk.action.OnItemActionListener;
import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;

import org.weex.plugin.weexplugincalendar.R;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.ui.widget.CalendarLabelRecyclerView;
import org.weex.plugin.weexplugincalendar.calendar.ui.widget.CalendarYearRecyclerView;
import org.weex.plugin.weexplugincalendar.calendar.ui.widget.DividerLine;
import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;
import org.weex.plugin.weexplugincalendar.calendar.util.WeekUtil;
import org.weex.plugin.weexplugincalendar.calendar.vm.BaseSubYearAdapter;
import org.weex.plugin.weexplugincalendar.calendar.vm.BaseSubYearItem;
import org.weex.plugin.weexplugincalendar.calendar.vm.SubYearLabelItem;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 周票房、月票房、档期票房的父类
 *
 * 因这三种票房选择，都是左右各一列表。左为年列表，右为周、月、档期列表。
 *
 * Created by pengfei on 17/2/27.
 */

public abstract class CalendarWMPFragment extends BaseCalendarPageFragment
        implements CalendarYearRecyclerView.OnYearSelectedListener, CalendarLabelRecyclerView.OnLabelChangedListener,
        OnItemActionListener, View.OnClickListener {

    protected CalendarYearRecyclerView yearListView;

    protected CalendarLabelRecyclerView rightListView;

    protected BaseSubYearAdapter adapter;

    protected Map<String, Integer> labelPositionMap;

    protected List<GroupDateModel> selectedDates = new ArrayList<>();

//    protected int mode;

//    protected GroupDateModel startDate;
//
//    protected GroupDateModel endDate;

    @Override
    public View onCreateContentView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_calendar_week, null);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        confirmBtn.setOnClickListener(this);

        yearListView = (CalendarYearRecyclerView) view.findViewById(R.id.rv_calendar_left_year_list);
        rightListView = (CalendarLabelRecyclerView) view.findViewById(R.id.rv_calendar_right_item_list);
        yearListView.setOnYearSelectedListener(this);
        int start = 2016;
        Calendar endCal = CalendarUtil.getCalendarInstance();
        endCal.setTimeInMillis(options.config.currentTs);
        int end = endCal.get(Calendar.YEAR);
        try { // get start year from config;
            Date startDate = CalendarUtil.DEFAULT_FORMATER.parse(options.config.startDate);
            Calendar calendar = CalendarUtil.getCalendarInstance();
            calendar.setTime(startDate);
            start = calendar.get(Calendar.YEAR);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // be sure to call after you changed start/end value in sub class
         yearListView.init(start, end);


        rightListView.setLayoutManager(new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false));
        DividerLine dividerLine = new DividerLine(DividerLine.VERTICAL);
        dividerLine.setColor(getResources().getColor(R.color.calendar_divider));
        dividerLine.setSize(getResources().getDimensionPixelSize(R.dimen.divide_line));
        rightListView.addItemDecoration(dividerLine);
        rightListView.setLabelViewType(BaseSubYearItem.TYPE_LABEL);
        adapter = new BaseSubYearAdapter(getActivity());
        rightListView.setAdapter(adapter);

        adapter.setDataList(createData(start, end));
        adapter.setOnItemActionListener(this);

        rightListView.setOnLabelChangedListener(this);

    }

    protected final void initLeftYearList(int start, int end) {
        if (this.yearListView != null) {
            this.yearListView.init(start, end);
        }
    }

    protected List<BaseSubYearItem> createData(int startYear, int endYear) {

        List<BaseSubYearItem> dataList = new ArrayList<>();
        labelPositionMap = new HashMap<>();

        // 本年的只添加到本周
        Calendar calendar = CalendarUtil.getCalendarInstance();
        int currentWeek = calendar.get(Calendar.WEEK_OF_YEAR);
        List<GroupDateModel> endYearWeeks;
        if (endYear == calendar.get(Calendar.YEAR)) {
            endYearWeeks = WeekUtil.getWeeksByYear(endYear, currentWeek);
        } else {
            endYearWeeks = WeekUtil.getWeeksByYear(endYear);
        }
        // add label
        dataList.add(new SubYearLabelItem(endYear + "年", String.valueOf(endYear)));
        labelPositionMap.put(String.valueOf(endYear), 0);
        // add weeks in desc order
        for (int i = endYearWeeks.size() - 1; i >= 0; i--) {
            GroupDateModel model = endYearWeeks.get(i);
            dataList.add(new WeekItem(model, 0, model.start.week == currentWeek));
        }

        for (int y = endYear - 1; y >= startYear; y--) {
            // add label
            int labelPosition = dataList.size();
            SubYearLabelItem label = new SubYearLabelItem(y + "年", String.valueOf(y));
            dataList.add(label);
            labelPositionMap.put(String.valueOf(y), labelPosition);
            // add weeks in desc order
            List<GroupDateModel> modelList = WeekUtil.getWeeksByYear(y);
            for (int w = modelList.size() - 1; w >= 0; w--) {
                GroupDateModel model = modelList.get(w);
                dataList.add(new WeekItem(model, labelPosition));
            }
        }
        return dataList;
    }

    @Override
    public void onYearSelected(View view, int position, int year) {
        int index = 0;
        try {
            index = labelPositionMap.get(String.valueOf(year));
        } catch (Exception e) { // throw nullpointer if map does not contains year
            e.printStackTrace();
            return;
        }
        //toast("onYearSelected/in year:" + year + " pos:" + index);
        LinearLayoutManager manager = (LinearLayoutManager) rightListView.getLayoutManager();
        manager.scrollToPositionWithOffset(index, 0);
    }

    @Override
    public void onLabelChanged(RecyclerView.ViewHolder holder, int position, Object data) {
        SubYearLabelItem label = (SubYearLabelItem) adapter.getItem(position);
        String labelStr = label.labelId;
        int index = yearListView.findPositionByData(labelStr);
        //toast("onLabelChanged/in label:" + index);
        yearListView.setSelectedPosition(index);
    }

    @Override
    public void onItemClick(BaseViewHolder baseViewHolder, View v, int position, Object data) {
        //toast("onItemClick pos:" + position);
        //rightListView.setSelectedItem(position);
    }

    @Override
    public void onItemLongClick(BaseViewHolder baseViewHolder, View v, int position, Object data) {

    }

    @Override
    public void onEvent(int eventId, BaseViewHolder baseViewHolder, View v, int position, Object data) {

    }

    @Override
    public void onClick(View v) {

    }

    public static class WeekItem extends BaseSubYearItem<BaseSubYearItem.RightItemViewHolder> {

        public GroupDateModel model;

        WeekItem(GroupDateModel model, int labelPos) {
            this(model, labelPos, false);
        }

        WeekItem(GroupDateModel model, int labelPos, boolean isCurrent) {
            this.model = model;
            this.labelPos = labelPos;
            this.isCurrent = isCurrent;
        }

        @Override
        public int getViewType() {
            return BaseSubYearItem.TYPE_WEEK;
        }

        @Override
        public void bindView(Context context, RightItemViewHolder viewHolder) {
            super.bindView(context, viewHolder);
            viewHolder.title.setText("第" + model.start.week + "周");
            StringBuilder builder = new StringBuilder(model.toDayRangeString());
            if (isCurrent) {
                builder.append("本周");
            }
            viewHolder.subtitle.setText(builder.toString());
            if (isSelected) {
                this.getItemView().setSelected(true);
            } else {
                this.getItemView().setSelected(false);
            }
        }
    }


}
