package org.weex.plugin.weexplugincalendar.calendar.vm;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import org.weex.plugin.weexplugincalendar.R;

/**
 * Created by pengfei on 17/3/2.
 */

public class SubYearLabelItem extends BaseSubYearItem<SubYearLabelItem.SubYearLabelViewHolder> {

    public String label;

    public String labelId;

    public SubYearLabelItem(String label, String labelId) {
        this.label = label;
        this.labelId = labelId;
    }

    @Override
    public int getViewType() {
        return BaseSubYearItem.TYPE_LABEL;
    }

    @Override
    public void bindView(Context context, SubYearLabelViewHolder viewHolder) {
        super.bindView(context, viewHolder);
        viewHolder.title.setText(label);
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof SubYearLabelItem) {
            return label.equals(((SubYearLabelItem) o).label);
        }
        return false;
    }

    //@ViewHolder(layoutId = R.layout.item_calendar_right_label)
    public static class SubYearLabelViewHolder extends BaseSubYearViewHolder {

        public static SubYearLabelViewHolder newInstance(Context context, ViewGroup parent) {
            View view = LayoutInflater.from(context).inflate(R.layout.item_calendar_right_label, parent, false);
            return new SubYearLabelViewHolder(view);
        }

        private TextView title;


        public SubYearLabelViewHolder(View itemView) {
            super(itemView);
            title = (TextView) itemView.findViewById(R.id.tv_calendar_right_label);
        }
    }
}
