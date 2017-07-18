package com.alipictures.cozyadapter.sdk.adapter;

import android.content.Context;

import com.alipictures.cozyadapter.sdk.vh.AbsLegacyViewHolder;
import com.alipictures.cozyadapter.sdk.vm.BaseViewModel;

import java.util.List;

/**
 * Created by pengfei on 16/9/28.
 */
public abstract class AbsLegacyRawAdapter<Raw, VM extends BaseViewModel, VH extends AbsLegacyViewHolder>
        extends AbsLegacyAdapter<VM, VH> {
    public AbsLegacyRawAdapter(Context context) {
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
