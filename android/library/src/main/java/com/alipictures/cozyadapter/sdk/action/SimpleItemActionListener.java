package com.alipictures.cozyadapter.sdk.action;

import android.view.View;

import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;

/**
 * Created by pengfei on 16/12/22.
 */
public abstract class SimpleItemActionListener<T extends BaseViewHolder> implements OnItemActionListener<T> {

    @Override
    public void onItemLongClick(T t, View v, int position, Object data) {

    }

    @Override
    public void onEvent(int eventId, T t, View v, int position, Object data) {

    }
}
