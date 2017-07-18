package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.alipictures.cozyadapter.sdk.action.OnItemActionListener;
import com.alipictures.cozyadapter.sdk.adapter.CozyRecyclerAdapter;
import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;
import com.alipictures.cozyadapter.sdk.vh.CozyViewHolder;
import com.alipictures.cozyadapter.sdk.vh.ViewHolder;
import com.alipictures.cozyadapter.sdk.vm.CozyItem;

import org.weex.plugin.weexplugincalendar.R;
import org.weex.plugin.weexplugincalendar.calendar.SelectMode;
import org.weex.plugin.weexplugincalendar.calendar.model.DateModel;
import org.weex.plugin.weexplugincalendar.calendar.model.GroupDateModel;
import org.weex.plugin.weexplugincalendar.calendar.ui.widget.DividerLine;
import org.weex.plugin.weexplugincalendar.calendar.util.CalendarUtil;
import org.weex.plugin.weexplugincalendar.calendar.util.DateUnit;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * Created by pengfei on 17/2/27.
 */

public class CalendarYearFragment extends BaseCalendarPageFragment implements OnItemActionListener,
        View.OnClickListener {

    RecyclerView yearListView;

    CozyRecyclerAdapter<YearItem, YearViewHolder> adapter;

    private int lastSelectedPosition = -1;

    private int mode;

    protected List<GroupDateModel> selectedDates = new ArrayList<>();

    private int passedInYearStart = -1;
    private int passedInYearEnd = -1;
    private int initScrollToPos = -1;

    @Override
    public View onCreateContentView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_calendar_year, null);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        this.mode = findModeForType(DateUnit.TYPE_YEAR);
        maxUnit = options.config.maxYears;
        if (this.mode == SelectMode.RANGE) {
            rangeConfirmContainer.setVisibility(View.VISIBLE);
            confirmBtn.setOnClickListener(this);
        } else {
            rangeConfirmContainer.setVisibility(View.GONE);
        }
        // get passed-in selected year(s)
        if (options.currentModel != null && options.currentModel.type == DateUnit.TYPE_YEAR) {
            passedInYearStart = options.currentModel.start.year;
            passedInYearEnd = options.currentModel.end.year;
        }

        yearListView = (RecyclerView) view.findViewById(R.id.rv_calendar_year_fragment);
        yearListView.setLayoutManager(new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false));
        DividerLine dividerLine = new DividerLine(DividerLine.VERTICAL);
        dividerLine.setColor(getResources().getColor(R.color.calendar_divider));
        dividerLine.setSize(getResources().getDimensionPixelSize(R.dimen.divide_line));
        yearListView.addItemDecoration(dividerLine);
        adapter = new CozyRecyclerAdapter<>(getActivity());
        adapter.setOnItemActionListener(this);
        yearListView.setAdapter(adapter);

        int start = 2016;
        Calendar endCal = CalendarUtil.getCalendarInstance();
        endCal.setTimeInMillis(options.config.currentTs);
        int end = endCal.get(Calendar.YEAR);
        /**
         * since 1.1.0. end year can be configured too!
         */
        end += options.config.yearDelta;
        try { // get start year from config;
            Date startDate = CalendarUtil.DEFAULT_FORMATER.parse(options.config.startDate);
            Calendar calendar = CalendarUtil.getCalendarInstance();
            calendar.setTime(startDate);
            start = calendar.get(Calendar.YEAR);
        } catch (Exception e) {
            e.printStackTrace();
        }
        prepareData(start, end);

    }

    private void prepareData(int startYear, int endYear) {
        if (startYear <= 0 || endYear <= 0 || startYear > endYear) {
            return;
        }
        List<YearItem> result = new ArrayList<>();
        Calendar calendar = CalendarUtil.getCalendarInstance();
        calendar.setTimeInMillis(options.config.currentTs);
        int currentYear = calendar.get(Calendar.YEAR);
        /**
         * 今天为本年的第一天时，由于该年第一天还没过完，今天没有数据，导致该年也没数据，故不显示该年。
         */
        int firstShowYear = endYear;
        if (options.config.isSkipFirstDay == 1 && firstShowYear == calendar.get(
                Calendar.YEAR) && calendar.get(Calendar.DAY_OF_YEAR) == 1) {
            firstShowYear --;
        }
        int cnt = 0;
        for (int y = firstShowYear; y >= startYear; y--) {
            GroupDateModel model = new GroupDateModel();
            model.start = new DateModel(y, 1, 1);
            model.end = new DateModel(y, 12, 31);
            model.type = DateUnit.TYPE_YEAR;
//            if (currentYear == y) {
//                model.month = calendar.get(Calendar.MONTH) + 1;
//                model.day = calendar.get(Calendar.DAY_OF_MONTH);
//
//                model.end = new DateModel(y, model.month, model.day);
//            }
            YearItem item = new YearItem(model, currentYear == y);
            // check if selected
            item.isSelected = shouldSelected(model, passedInYearStart, passedInYearEnd, cnt);

            result.add(item);

            cnt++;
        }
        adapter.addItems(result);
        initSelectionState();
    }

    /**
     * called in prepareData, check if current date is passed-in selection
     * @param model
     * @param startYear
     * @param endYear
     * @return
     */
    private boolean shouldSelected(GroupDateModel model, int startYear, int endYear, int position) {
        if (model == null) {
            return false;
        }
        if (model.start.year == startYear) {
            selectedDates.add(model);
            initScrollToPos = position;
            return true;
        } else if (model.start.year > startYear && model.start.year < endYear) {
            return true;
        } else if (model.start.year == endYear) {
            selectedDates.add(model);
            return true;
        }
        return false;
    }

    /**
     * initialize selection state, refresh confirm container of range select mode and scroll to selection
     * @return
     */
    private void initSelectionState() {
        if (selectedDates.size() == 2) {
            refreshRangeEnd();
        } else if (mode == SelectMode.RANGE) {
            refreshRangeStart(null);
        }
        if (initScrollToPos != -1) {
            LinearLayoutManager layoutManager = (LinearLayoutManager) yearListView.getLayoutManager();
            layoutManager.scrollToPosition(initScrollToPos);
        }
    }

    @Override
    public void onItemClick(BaseViewHolder baseViewHolder, View v, int position, Object data) {
        GroupDateModel model = adapter.getItem(position).model;
        if (mode == SelectMode.SINGLE) {
            v.setSelected(true);
            notifyListener(model);
        } else if (mode == SelectMode.RANGE){
            if (selectedDates.size() == 0) { // range start
                setSelectedItem(position);
                selectedDates.add(model);
                refreshRangeStart(model);
            } else if (selectedDates.size() == 1) {
                // check if click the same month again
                if (CalendarUtil.isSameYear(model, selectedDates.get(0))) {
                    removeSelectedItem(position);
                    selectedDates.clear();
                    refreshRangeStart(null);
                } else if (!checkExceedLimit(selectedDates.get(0), model)) { // select all between start & end
                    selectedDates.add(model);
                    rangeSelect(position);
                    // refresh range view
                    refreshRangeEnd();
                }
            } else { // clear all selections and select this one
                removeAllSelectedItem();
                selectedDates.clear();
                selectedDates.add(model);
                setSelectedItem(position);
                refreshRangeStart(model);
            }
        }
    }

    private boolean checkExceedLimit(GroupDateModel start, GroupDateModel current) {
        if (start == null || current == null) {
            return false;
        }
        int startYear = start.start.year;
        int endYear = current.end.year;
        if (Math.abs(endYear - startYear) +1 > maxUnit) {
            Toast.makeText(getActivity(), "最多可选择" + maxUnit + "年", Toast.LENGTH_LONG).show();
            return true;
        }
        return false;
    }

    @Override
    public void onItemLongClick(BaseViewHolder baseViewHolder, View v, int position, Object data) {

    }

    @Override
    public void onEvent(int eventId, BaseViewHolder baseViewHolder, View v, int position, Object data) {

    }

    protected void refreshRangeStart(GroupDateModel startDate) {
        if (startDate != null) {
            startDateView.setText(startDate.toYearString());
            endDateView.setText(null);
            confirmBtn.setEnabled(false);
            staticToast.setVisibility(View.VISIBLE);
            staticToast.setText(R.string.calendar_toast_select_end);
        } else {
            startDateView.setText(null);
            endDateView.setText(null);
            confirmBtn.setEnabled(false);
            staticToast.setVisibility(View.VISIBLE);
            staticToast.setText(R.string.calendar_toast_select_start);
        }
    }

    protected void refreshRangeEnd() {
        GroupDateModel startDate = selectedDates.get(0);
        GroupDateModel endDate = selectedDates.get(1);
        if (startDate == null || endDate == null) {
            return;
        }
        if (CalendarUtil.isBefore(endDate, startDate)) {
            Collections.reverse(selectedDates);
            startDate = selectedDates.get(0);
            endDate = selectedDates.get(1);
        }
        startDateView.setText(startDate.toYearString());
        endDateView.setText(endDate.toYearString());
        confirmBtn.setEnabled(true);
        staticToast.setVisibility(View.GONE);
    }

    @Override
    public void onClick(View v) {
        if (v == confirmBtn) {
            GroupDateModel model = new GroupDateModel();
            model.type = DateUnit.TYPE_YEAR;
            model.start = selectedDates.get(0).start;
            model.end = selectedDates.get(1).end;
            notifyListener(model);
        }
    }

    private void setSelectedItem(int position) {
        if (lastSelectedPosition != position) {
            YearItem item = adapter.getItem(position);
            item.isSelected = true;
            adapter.notifyItemChanged(position);
            lastSelectedPosition = position;
        }
    }

    private void removeSelectedItem(int position) {
        YearItem item = adapter.getItem(position);
        item.isSelected = false;
        adapter.notifyItemChanged(position);
        if (position == lastSelectedPosition) {
            lastSelectedPosition = -1;
        }
    }

    private void removeAllSelectedItem() {
        for (YearItem item: adapter.getItemList()) {
            if (item != null) {
                item.isSelected = false;
            }
        }
        lastSelectedPosition = -1;
        adapter.notifyDataSetChanged();
    }

    private void rangeSelect(int position) {
        int start = lastSelectedPosition;
        int end = position;
        if (start > end) {
            start = position;
            end = lastSelectedPosition;
        }
        for (int i = start; i <= end; i++) {
            YearItem item = adapter.getItem(i);
            item.isSelected = true;
        }
        adapter.notifyItemRangeChanged(start, end - start + 1);
    }

    public static class YearItem extends CozyItem<YearViewHolder> {

        public GroupDateModel model;

        public boolean isCurrentYear;

        public boolean isSelected;

        public YearItem(GroupDateModel model, boolean isCurrentYear) {
            this.model = model;
            this.isCurrentYear = isCurrentYear;
        }

        public YearItem(GroupDateModel model) {
            this(model, false);
        }

        @Override
        public void bindView(Context context, YearViewHolder viewHolder) {
            super.bindView(context, viewHolder);
            viewHolder.title.setText(model.toYearString());
            if (isCurrentYear) {
                viewHolder.subtitle.setVisibility(View.VISIBLE);
//                StringBuilder builder = new StringBuilder();
//                builder.append(model.year).append("/");
//                if (model.month < 10) {
//                    builder.append(0);
//                }
//                builder.append(model.month).append("/");
//                if (model.day < 10) {
//                    builder.append(0);
//                }
//                builder.append(model.day);
//                String fullStr = context.getString(R.string.calendar_current_year_text, builder.toString());
                viewHolder.subtitle.setText(R.string.calendar_current_year_label);
            } else {
                viewHolder.subtitle.setVisibility(View.GONE);
            }

            if (isSelected) {
                this.getItemView().setSelected(true);
            } else {
                this.getItemView().setSelected(false);
            }
        }

    }

    // @ViewHolder(layoutId = R.layout.item_calendar_right_list) lib工程不行，id不是final的
    public static class YearViewHolder extends CozyViewHolder implements View.OnClickListener {

        public static YearViewHolder newInstance(Context context, ViewGroup parent) {
            View view = LayoutInflater.from(context).inflate(R.layout.item_calendar_right_list, parent, false);
            return new YearViewHolder(view);
        }

        TextView title;

        TextView subtitle;

        public YearViewHolder(View itemView) {
            super(itemView);
        }

        @Override
        public void findViews(View rootView) {
            super.findViews(rootView);
            title = (TextView) rootView.findViewById(R.id.tv_calendar_right_title);
            subtitle = (TextView) rootView.findViewById(R.id.tv_calendar_right_subtitle);
        }

        @Override
        public void applyActionListener() {
            super.applyActionListener();
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            if (listener != null) {
                listener.onItemClick(this, v, getAdapterPosition(), null);
            }
        }
    }
}
