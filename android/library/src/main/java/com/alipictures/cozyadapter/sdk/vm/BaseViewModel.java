package com.alipictures.cozyadapter.sdk.vm;

import android.content.Context;

import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;


/**
 * Created by pengfei on 16/9/21.
 */
public interface BaseViewModel<VH extends BaseViewHolder> {

    int getViewType();

    void bindView(Context context, VH viewHolder);
}
