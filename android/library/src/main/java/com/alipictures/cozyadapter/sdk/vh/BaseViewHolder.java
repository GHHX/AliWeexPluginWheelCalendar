package com.alipictures.cozyadapter.sdk.vh;

import android.view.View;


/**
 * Created by pengfei on 16/9/21.
 */
public interface BaseViewHolder {

    /**
     *
     * @return root view
     */
    View getRootView();

    void findViews(View rootView);

    /**
     * subclass should override this method to set onClick/onLongClick listener to certain views.
     * @param onClickListener
     * @param onLongClickListener
     */
    //void applyActionListener(AbsLegacyActionRouter transmitter);

//    int getLayoutId();

//    View getLayoutView();
}
