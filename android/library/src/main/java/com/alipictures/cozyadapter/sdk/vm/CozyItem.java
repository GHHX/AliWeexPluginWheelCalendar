package com.alipictures.cozyadapter.sdk.vm;

import android.content.Context;
import android.view.View;

import com.alipictures.cozyadapter.sdk.vh.AbsRecyclerViewHolder;

import java.lang.ref.WeakReference;

/**
 * Created by pengfei on 16/12/16.
 */
public class CozyItem<VH extends AbsRecyclerViewHolder> implements BaseViewModel<VH> {

    WeakReference<View> itemView;

    @Override
    public int getViewType() {
        return 0;
    }

    @Override
    public void bindView(Context context, VH viewHolder) {
        itemView = new WeakReference<>(viewHolder.getRootView());
    }

    public View getItemView() {
        if (itemView != null) {
            return itemView.get();
        }
        return null;
    }
}
