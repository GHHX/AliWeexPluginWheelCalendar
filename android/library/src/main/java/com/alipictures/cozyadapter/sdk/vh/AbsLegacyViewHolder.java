package com.alipictures.cozyadapter.sdk.vh;

import android.view.View;

/**
 * Created by pengfei on 16/9/22.
 */
public abstract class AbsLegacyViewHolder implements BaseViewHolder{

    private View rootView;

    public AbsLegacyViewHolder(View rootView) {
        this.rootView = rootView;
        this.findViews(rootView);
    }

    @Override
    public View getRootView() {
        return this.rootView;
    }
}
