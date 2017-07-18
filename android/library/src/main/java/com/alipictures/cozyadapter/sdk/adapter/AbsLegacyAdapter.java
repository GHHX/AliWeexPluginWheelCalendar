package com.alipictures.cozyadapter.sdk.adapter;

import android.content.Context;
import android.database.DataSetObserver;
import android.view.View;
import android.view.ViewGroup;

import com.alipictures.cozyadapter.sdk.vh.AbsLegacyViewHolder;
import com.alipictures.cozyadapter.sdk.vm.BaseViewModel;

import org.weex.plugin.weexplugincalendar.R;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pengfei on 16/9/22.
 */
public abstract class AbsLegacyAdapter<VM extends BaseViewModel, VH extends AbsLegacyViewHolder> extends android.widget.BaseAdapter
        implements BaseAdapter<VM, VH> {

    protected Context mContext = null;

    private List<VM> mDataList = null;

    public AbsLegacyAdapter(Context context) {
        this.mContext = context;
    }

    // inherited methods from android.widget.BaseAdapter
    @Override
    public int getCount() {
        return this.getItemCount();
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        VH viewHolder;
        if (convertView == null) {
            int viewType = getItemViewType(position);
            viewHolder = onCreateViewHolder(parent, viewType);
            convertView = viewHolder.getRootView();
            convertView.setTag(viewHolder);
        }
        viewHolder = (VH) convertView.getTag();
        onBindViewHolder(viewHolder, position);
        convertView.setTag(R.id.key_view_position, position);
        return convertView;
    }

    // inherited methods from both

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

    // inherited methods from interface BaseAdapter

    @Override
    public void setDataList(List<VM> dataList) {
        this.mDataList = dataList;
        this.notifyDataSetChanged();
    }

    @Override
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

    @Override
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
    public VH onCreateViewHolder(ViewGroup viewGroup, int viewType) {
        VH holder = createViewHolder(mContext, viewGroup,
                viewType);
        return holder;
    }

    @Override
    public void onBindViewHolder(VH viewHolder, int position) {
        BaseViewModel model = getItem(position);
        model.bindView(mContext, viewHolder);
    }

    @Override
    public int getItemCount() {
        if (mDataList == null) {
            return 0;
        }
        return mDataList.size();
    }

    @Override
    public abstract int getViewTypeCount();

    @Override
    public void unregisterDataSetObserver(DataSetObserver observer) {
        // when used in ViewPager on Android 4.0, observer may be null
        if (observer != null) {
            super.unregisterDataSetObserver(observer);
        }
    }
}
