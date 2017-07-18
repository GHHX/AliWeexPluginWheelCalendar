package com.alipictures.cozyadapter.sdk.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.ViewGroup;

import com.alipictures.cozyadapter.sdk.vh.AbsRecyclerViewHolder;
import com.alipictures.cozyadapter.sdk.vm.BaseViewModel;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pengfei on 16/9/22.
 */
public abstract class AbsRecyclerAdapter<VM extends BaseViewModel, VH extends AbsRecyclerViewHolder> extends RecyclerView.Adapter<VH>
        implements BaseAdapter<VM, VH> {

    protected Context mContext = null;

    protected List<VM> mDataList = null;

    //protected OnItemActionListener mItemActionListener = null;

    public AbsRecyclerAdapter(Context context) {
        this.mContext = context;
    }

    @Override
    public void setDataList(List<VM> dataList) {
        this.mDataList = dataList;
        this.notifyDataSetChanged();
    }

    public void appendDataList(List<VM> dataList) {
        if (dataList == null) {
            return;
        }
        if (mDataList == null) {
            mDataList = new ArrayList<>();
        }
        mDataList.addAll(dataList);
        this.notifyDataSetChanged();
    }

    public VM getItem(int position) {
        if (mDataList != null) {
            try {
                return mDataList.get(position);
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }
        return null;
    }

    @Override
    public int getItemViewType(int position) {
        VM t = getItem(position);
        try {
            return t.getViewType();
        } catch (NullPointerException e) {
            e.printStackTrace();
            return super.getItemViewType(position);
        }
    }

    @Override
    public VH onCreateViewHolder(ViewGroup viewGroup, int viewType) {
         VH holder = createViewHolder(mContext, viewGroup, viewType);
        //holder.applyActionListener(new ClickActionTransmitter<>(mItemActionListener, holder), null);
        return holder;
    }

    @Override
    public abstract VH createViewHolder(Context context, ViewGroup viewGroup, int viewType);

    @Override
    public void onBindViewHolder(AbsRecyclerViewHolder baseTagViewHolder, int i) {
        BaseViewModel model = getItem(i);
        model.bindView(mContext, baseTagViewHolder);
    }

    @Override
    public int getItemCount() {
        if (mDataList == null) {
            return 0;
        }
        return mDataList.size();
    }

    protected Context getContext() {
        return mContext;
    }

    //public void setItemActionListener(OnItemActionListener itemActionListener) {
    //    this.mItemActionListener = itemActionListener;
    //}

}
