package com.alipictures.cozyadapter.sdk.vh;

import android.util.SparseArray;
import android.view.View;


/**
 * Created by pengfei on 16/9/22.
 */
public class CozyViewHolder extends AbsRecyclerViewHolder {

    private SparseArray<View> viewHolderSparseArr;

    public CozyViewHolder(View itemView) {
        super(itemView);
    }

    @Override
    public void findViews(View rootView) {

    }

    public <V extends View> V findViewById(int id) {
        if (this.viewHolderSparseArr == null) {
            this.viewHolderSparseArr = new SparseArray<View>(4);
        }

        View childView = viewHolderSparseArr.get(id);
        if (childView == null) {
            childView = this.itemView.findViewById(id);
            this.viewHolderSparseArr.put(id, childView);
        }

        return (V) childView;
    }
}
