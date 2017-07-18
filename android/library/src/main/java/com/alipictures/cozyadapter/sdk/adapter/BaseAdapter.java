package com.alipictures.cozyadapter.sdk.adapter;

import android.content.Context;
import android.view.ViewGroup;

import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;
import com.alipictures.cozyadapter.sdk.vm.BaseViewModel;

import java.util.List;

/**
 * Created by pengfei on 16/9/22.
 */
public interface BaseAdapter<VM extends BaseViewModel, VH extends BaseViewHolder> {

    /**
     * set data list to this adapter, old dataset will be replaced
     * @param dataList
     */
    void setDataList(List<VM> dataList);

    /**
     * append new data to the tail of the current dataset
     * @param dataList
     */
    void appendDataList(List<VM> dataList);

    /**
     * get data at the specified position
     * @param position
     * @return
     */
    VM getItem(int position);

    /**
     * get item view type at the specified position
     * @param position
     * @return
     */
    int getItemViewType(int position);

    /**
     * create view holder for the specified view type
     * @param viewGroup
     * @param viewType
     * @return
     */
    VH onCreateViewHolder(ViewGroup viewGroup, int viewType);

    /**
     * create
     * @param context
     * @param viewGroup
     * @param viewType
     * @return
     */
    VH createViewHolder(Context context, ViewGroup viewGroup, int viewType);

    /**
     * called when bind data to view
     * @param viewHolder
     * @param i
     */
    void onBindViewHolder(VH viewHolder, int i);

    /**
     *
     * @return count of data set
     */
    int getItemCount();
}
