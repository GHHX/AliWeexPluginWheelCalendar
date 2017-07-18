package org.weex.plugin.weexplugincalendar.calendar.vm;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.alipictures.cozyadapter.sdk.vm.CozyItem;

import org.weex.plugin.weexplugincalendar.R;

/**
 * 周、月、档期列表的base view model。
 * 这种列表一般和左侧的年份列表一起出现。
 *
 * Created by pengfei on 17/3/1.
 */

public abstract class BaseSubYearItem<VH extends BaseSubYearViewHolder> extends CozyItem<VH> {

    public static final int TYPE_LABEL = 1;
    public static final int TYPE_WEEK = 2;
    public static final int TYPE_MONTH = 3;
    public static final int TYPE_PERIOD = 4;

    int type;

    public boolean isSelected;

    public boolean isCurrent;

    public int labelPos;

    @Override
    public int getViewType() {
        return type;
    }

    //@ViewHolder(layoutId = R.layout.item_calendar_right_list)
    public static class RightItemViewHolder extends BaseSubYearViewHolder {

        public static RightItemViewHolder newInstance(Context context, ViewGroup parent) {
            View view = LayoutInflater.from(context).inflate(R.layout.item_calendar_right_list, parent, false);
            return new RightItemViewHolder(view);
        }

        public TextView title;

        public TextView subtitle;

        public RightItemViewHolder(View itemView) {
            super(itemView);
            title = (TextView) itemView.findViewById(R.id.tv_calendar_right_title);
            subtitle = (TextView) itemView.findViewById(R.id.tv_calendar_right_subtitle);
        }

        @Override
        public void applyActionListener() {
            super.applyActionListener();
            this.itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            super.onClick(v);
            if (this.listener != null) {
                this.listener.onItemClick(this, v, getAdapterPosition(), null);
            }
        }
    }
}
