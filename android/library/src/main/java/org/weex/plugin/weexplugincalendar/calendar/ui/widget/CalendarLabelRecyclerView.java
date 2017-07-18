package org.weex.plugin.weexplugincalendar.calendar.ui.widget;

import android.content.Context;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.AttributeSet;
import android.view.View;

import com.alipictures.cozyadapter.sdk.adapter.CozyRecyclerAdapter;

import org.weex.plugin.weexplugincalendar.calendar.vm.BaseSubYearAdapter;
import org.weex.plugin.weexplugincalendar.calendar.vm.BaseSubYearItem;
import org.weex.plugin.weexplugincalendar.calendar.vm.BaseSubYearViewHolder;

/**
 * Created by pengfei on 17/3/2.
 */

public class CalendarLabelRecyclerView extends RecyclerView {

    private OnLabelChangedListener listener;

    private int currentLabelPosition;

    private int labelViewType;

    /** last selected position */
    private int selectedPosition;

    private int selectedRangeStart;

    private int selectedRangeEnd;

    public CalendarLabelRecyclerView(Context context) {
        super(context);
        initViews(context);
    }

    public CalendarLabelRecyclerView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        initViews(context);
    }

    private void initViews(Context context) {
        setLayoutManager(new LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false));
        addOnScrollListener(new OnScrollListener() {
            @Override
            public void onScrollStateChanged(RecyclerView recyclerView, int newState) {
                super.onScrollStateChanged(recyclerView, newState);
            }

            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);
                View childView = recyclerView.getChildAt(0);
                ViewHolder holder = recyclerView.getChildViewHolder(childView);
                int position = holder.getAdapterPosition();
                BaseSubYearItem item = ((CozyRecyclerAdapter<BaseSubYearItem, BaseSubYearViewHolder>) getAdapter()).getItem(position);
                //LogUtil.d("wpf", "onScrolled/in pos:" + position + " view type:" + item.getViewType() + " label:" + item.labelPos);
                if (item.getViewType() != BaseSubYearItem.TYPE_LABEL) {
                    int labelPos = item.labelPos;
                    if (labelPos != currentLabelPosition) {
                        currentLabelPosition = labelPos;
                        if (listener != null) {
                            listener.onLabelChanged(holder, labelPos, item);
                        }
                    }
                }
            }
        });
    }

    public void setLabelViewType(int type) {
        this.labelViewType = type;
    }

    public void setSelectedItem(int position) {
        if (position != selectedPosition) {
            selectedPosition = position;
            ((BaseSubYearAdapter) getAdapter()).getItem(position).isSelected = true;
            getAdapter().notifyItemChanged(position);
        }
    }

    public void selectRange(int endPosition) {
        int start = selectedPosition;
        int end = endPosition;
        if (selectedPosition > endPosition) {
            start = endPosition;
            end = selectedPosition;
        }
        for (int i =  start; i <= end; i++) {
            BaseSubYearItem item = ((BaseSubYearAdapter) getAdapter()).getItem(i);
            if (item != null && item.getViewType() != BaseSubYearItem.TYPE_LABEL) {
                item.isSelected = true;
            }
        }
        getAdapter().notifyItemRangeChanged(start, end - start + 1);
    }

    public void removeSelectedItem(int position) {
        ((BaseSubYearAdapter) getAdapter()).getItem(position).isSelected = false;
        getAdapter().notifyItemChanged(position);
        if (position == selectedPosition) {
            selectedPosition = -1;
        }
    }

    public void removeAllSelectedItem() {
        for (BaseSubYearItem item : ((BaseSubYearAdapter) getAdapter()).getItemList()) {
            item.isSelected = false;
            getAdapter().notifyDataSetChanged();
        }
        selectedPosition = -1;
    }

    public void setOnLabelChangedListener(OnLabelChangedListener listener) {
        this.listener = listener;
    }


    public interface OnLabelChangedListener {
        void onLabelChanged(ViewHolder holder, int position, Object data);
    }
}
