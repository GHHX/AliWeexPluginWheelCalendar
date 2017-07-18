package com.alipictures.cozyadapter.sdk.adapter;

import android.content.Context;

import com.alipictures.cozyadapter.sdk.vh.AbsRecyclerViewHolder;
import com.alipictures.cozyadapter.sdk.vm.BaseViewModel;

import java.util.List;

/**
 * Created by pengfei on 16/9/28.
 */
public abstract class AbsRecyclerRawAdapter<Raw, VM extends BaseViewModel, VH extends AbsRecyclerViewHolder>
        extends AbsRecyclerAdapter<VM, VH> {
    public AbsRecyclerRawAdapter(Context context) {
        super(context);
    }

    public void setRawDataList(List<Raw> dataList) {
        super.setDataList(convertRaw2VM(dataList));
    }

    public void appendRawDataList(List<Raw> dataList) {
        super.appendDataList(convertRaw2VM(dataList));
    }

    protected abstract List<VM> convertRaw2VM(List<Raw> rawData);
}
