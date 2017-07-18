package org.weex.plugin.weexplugincalendar.calendar.vm;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.alipictures.cozyadapter.sdk.adapter.CozyRecyclerAdapter;

import org.weex.plugin.weexplugincalendar.R;

/**
 * Created by pengfei on 17/3/2.
 */

public class BaseSubYearAdapter extends CozyRecyclerAdapter<BaseSubYearItem, BaseSubYearViewHolder> {

    LayoutInflater inflater;

    public BaseSubYearAdapter(Context context) {
        super(context);
        inflater = LayoutInflater.from(context);
    }

    @Override
    public int getItemViewType(int position) {
        return getItem(position).getViewType();
    }

    @Override
    public BaseSubYearViewHolder onCreateViewHolder(ViewGroup viewGroup, int viewType) {
        BaseSubYearViewHolder holder = null;
        switch (viewType) {
            case BaseSubYearItem.TYPE_LABEL:
                View view = inflater.inflate(R.layout.item_calendar_right_label, viewGroup, false);
                holder = new SubYearLabelItem.SubYearLabelViewHolder(view);
                holder.setActionListener(internalListner);
                break;
            case BaseSubYearItem.TYPE_WEEK:
                view = inflater.inflate(R.layout.item_calendar_right_list, viewGroup, false);
                holder = new BaseSubYearItem.RightItemViewHolder(view);
                holder.setActionListener(internalListner);
                break;
            case BaseSubYearItem.TYPE_MONTH:
                view = inflater.inflate(R.layout.item_calendar_right_list, viewGroup, false);
                holder = new BaseSubYearItem.RightItemViewHolder(view);
                holder.setActionListener(internalListner);
                break;
            case BaseSubYearItem.TYPE_PERIOD:
                view = inflater.inflate(R.layout.item_calendar_right_list, viewGroup, false);
                holder = new BaseSubYearItem.RightItemViewHolder(view);
                holder.setActionListener(internalListner);
                break;
        }
        return holder;
    }
}
