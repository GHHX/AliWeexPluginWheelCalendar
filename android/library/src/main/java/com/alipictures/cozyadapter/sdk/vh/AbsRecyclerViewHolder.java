package com.alipictures.cozyadapter.sdk.vh;

import android.support.v7.widget.RecyclerView;
import android.view.View;

import com.alipictures.cozyadapter.sdk.action.OnItemActionListener;


/**
 * Created by pengfei on 16/9/22.
 */
public abstract class AbsRecyclerViewHolder extends RecyclerView.ViewHolder implements BaseViewHolder {

    protected OnItemActionListener listener;

    public AbsRecyclerViewHolder(View itemView) {
        super(itemView);
        findViews(itemView);
        applyActionListener();
    }

    @Override
    public View getRootView() {
        return itemView;
    }

    public final void setActionListener(OnItemActionListener listener) {
        this.listener = listener;
    }

    public void applyActionListener() {

    }
}
