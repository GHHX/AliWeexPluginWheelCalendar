package org.weex.plugin.weexplugincalendar.calendar.ui.widget;

import android.content.Context;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import org.weex.plugin.weexplugincalendar.R;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pengfei on 17/3/1.
 */

public class CalendarYearRecyclerView extends RecyclerView {


    private YearAdapter adapter;

    private int selectedIndex = 0;

    private OnYearSelectedListener listener;

    public CalendarYearRecyclerView(Context context) {
        super(context);
        initViews(context);
    }

    public CalendarYearRecyclerView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        initViews(context);
    }


    private void initViews(Context context) {
        setLayoutManager(new LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false));
        setHasFixedSize(true);
        adapter = new YearAdapter(context);
        setAdapter(adapter);
    }


    public void init(int startYear, int endYear) {
        if (startYear < 2011 || startYear > endYear) {
            return;
        }
        List<String> dataList = new ArrayList<>();
        for (int i = endYear; i >= startYear; i--) {
            dataList.add(String.valueOf(i));
        }
        adapter.setDataList(dataList);
    }

    public int findPositionByData(String label) {
        return adapter.findItePosition(label);
    }

    public void setSelectedPosition(int position) {
        if (this.selectedIndex != position) {
            this.selectedIndex = position;
            adapter.notifyDataSetChanged();
        }
    }

    public void setOnYearSelectedListener(OnYearSelectedListener listener) {
        this.listener = listener;
    }

    public interface OnYearSelectedListener {
        void onYearSelected(View view, int position, int year);
    }

    private class YearAdapter extends RecyclerView.Adapter<YearViewHolder> {

        private LayoutInflater inflater;

        private List<String> dataList;

        YearAdapter(Context context) {
            inflater = LayoutInflater.from(context);
        }


        private void setDataList(List<String> list) {
            this.dataList = list;
            this.notifyDataSetChanged();
        }

        public String getItem(int position) {
            return dataList.get(position);
        }


        @Override
        public YearViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = inflater.inflate(R.layout.item_calendar_left_year_list, parent, false);
            YearViewHolder viewHolder = new YearViewHolder(view);
            viewHolder.setYearSelectListener(CalendarYearRecyclerView.this.listener);
            return viewHolder;
        }

        @Override
        public void onBindViewHolder(YearViewHolder holder, int position) {
            holder.yearView.setText(this.dataList.get(position));
            if (position == CalendarYearRecyclerView.this.selectedIndex) {
                holder.yearView.setSelected(true);
            } else {
                holder.yearView.setSelected(false);
            }
        }

        public int findItePosition(String item) {
            if (dataList != null) {
                return dataList.indexOf(item);
            }
            return -1;
        }

        @Override
        public int getItemCount() {
            return dataList != null ? dataList.size() : 0;
        }
    }

    private class YearViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener{

        TextView yearView;

        private OnYearSelectedListener listener;

        public YearViewHolder(View itemView) {
            super(itemView);
            yearView = (TextView) itemView.findViewById(R.id.tv_calendar_left_year);
            yearView.setOnClickListener(this);
        }

        public void setYearSelectListener(OnYearSelectedListener listener) {
            this.listener = listener;
        }

        @Override
        public void onClick(View v) {
            if (this.listener != null) {
                int position = getAdapterPosition();
                this.listener.onYearSelected(v, position,
                        Integer.valueOf(adapter.getItem(position)));
//                v.setSelected(true);
                CalendarYearRecyclerView.this.selectedIndex = position;
                adapter.notifyDataSetChanged();
            }
        }
    }
}
