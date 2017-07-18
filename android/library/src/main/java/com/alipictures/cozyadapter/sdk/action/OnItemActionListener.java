package com.alipictures.cozyadapter.sdk.action;

import android.view.View;

import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;


/**
 * Created by pengfei on 16/9/27.
 */
public interface OnItemActionListener<T extends BaseViewHolder> {

    void onItemClick(T t, View v, int position, Object data);

    void onItemLongClick(T t, View v, int position, Object data);

    void onEvent(int eventId, T t, View v, int position, Object data);

}
