package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import org.weex.plugin.weexplugincalendar.R;

/**
 * BaseMovieproFragment
 * <p>
 * 所有的Movie pro的 Fragment 就要继承或者间接继承  BaseMovieproFragment
 * <p>
 * 1. Injector  Injector尽量上提, 所有放到这里
 * 2. BaseTitleBar
 *
 * @author 卫晨(wenwei.ww@alibaba-inc.com)
 * @version 17/2/22
 */
public abstract class BaseFragment extends Fragment {

    /**
     * 创建 Fragment content view
     *
     * @param inflater
     * @param container
     * @param savedInstanceState
     * @return
     */
    public abstract View onCreateContentView(LayoutInflater inflater, ViewGroup container,
                                             Bundle savedInstanceState);


    @Override
    public final View onCreateView(LayoutInflater inflater, ViewGroup container,
                                   Bundle savedInstanceState) {
//        return inflater.inflate(R.layout.fragment_tag_search, null);
        View contentView = onCreateContentView(inflater, container, savedInstanceState);

        RelativeLayout contentContainer = (RelativeLayout) inflater.inflate(R.layout.fragment_base_layout, null);
        RelativeLayout.LayoutParams lpContent = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);


        contentContainer.addView(contentView, lpContent);

        return contentContainer;
    }


    /**
     * 显示 toast
     *
     * @param str
     */
    public void toast(String str) {
        if (getActivity() != null) {
//            ToastUtil.show(getActivity(), str, Toast.LENGTH_SHORT);
        }
    }

    /**
     * 显示 toast
     *
     * @param str
     * @param duration
     */
    public void toast(String str, int duration) {

        if (getActivity() != null) {
//            ToastUtil.show(getActivity(), str, duration);
        }
    }

    /**
     * 退出Activity
     */
    public void finishActivity() {
        if (getActivity() != null) {
            getActivity().finish();
        }
    }


    /**
     * 弹对话框
     *
     * @param title            标题
     * @param msg              消息
     * @param positive         确定
     * @param positiveListener 确定回调
     * @param negative         否定
     * @param negativeListener 否定回调
     */
//    @Override
//    public void alert(String title, String msg, String positive, DialogInterface.OnClickListener positiveListener, String negative, DialogInterface.OnClickListener negativeListener) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().alert(title, msg, positive, positiveListener, negative, negativeListener);
//        }
//    }

    /**
     * 弹对话框
     *
     * @param title                    标题
     * @param msg                      消息
     * @param positive                 确定
     * @param positiveListener         确定回调
     * @param negative                 否定
     * @param negativeListener         否定回调
     * @param isCanceledOnTouchOutside 是否可以点击外围框
     * @param contentView
     * @param edit
     */
//    @Override
//    public void alert(String title, String msg, String positive, DialogInterface.OnClickListener positiveListener, String negative, DialogInterface.OnClickListener negativeListener, Boolean isCanceledOnTouchOutside, View contentView, boolean edit) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().alert(title, msg, positive, positiveListener, negative, negativeListener, isCanceledOnTouchOutside, contentView, edit);
//        }
//    }

    /**
     * 弹对话框
     *
     * @param title                    标题
     * @param msg                      消息
     * @param positive                 确定
     * @param positiveListener         确定回调
     * @param negative                 否定
     * @param negativeListener         否定回调
     * @param isCanceledOnTouchOutside 是否可以点击外围框
     * @param contentView
     * @param edit
     * @param cancelable
     */
//    @Override
//    public void alert(String title, CharSequence msg, String positive, DialogInterface.OnClickListener positiveListener, String negative, DialogInterface.OnClickListener negativeListener, Boolean isCanceledOnTouchOutside, View contentView, boolean edit, boolean cancelable) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().alert(title, msg, positive, positiveListener, negative, negativeListener, isCanceledOnTouchOutside, contentView, edit, cancelable);
//        }
//    }

//    @Override
//    public void alert(String title, String msg, String positive, DialogInterface.OnClickListener positiveListener, String negative, DialogInterface.OnClickListener negativeListener, View view) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().alert(title, msg, positive, positiveListener, negative, negativeListener, view);
//        }
//    }

//    @Override
//    public void alert(String title, String msg, String positive, DialogInterface.OnClickListener positiveListener, String negative, DialogInterface.OnClickListener negativeListener, boolean edit) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().alert(title, msg, positive, positiveListener, negative, negativeListener, edit);
//        }
//    }

//    @Override
//    public void showProgressDialog(boolean showProgressBar, CharSequence msg) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().showProgressDialog(showProgressBar, msg);
//        }
//    }

//    @Override
//    public void showProgressDialog(CharSequence msg) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().showProgressDialog(msg);
//        }
//    }

//    @Override
//    public void showProgressDialog(CharSequence msg, boolean cancelable, DialogInterface.OnCancelListener cancelListener, boolean showProgressBar) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().showProgressDialog(msg, cancelable, cancelListener, showProgressBar);
//        }
//    }

//    @Override
//    public void dismissProgressDialog() {
//        if (getBaseActivity() != null) {
//            getBaseActivity().dismissProgressDialog();
//        }
//    }

    /**
     * 显示Light样式的加载 Dialog
     * 这个后面统一梳理一下
     *
     * @param msg
     */
//    @Override
//    public void showLightLoadingDialog(CharSequence msg) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().showLightLoadingDialog(msg);
//        }
//    }

//    @Override
//    public void showLightLoadingDialogWithDelay(CharSequence msg, long delayMillis) {
//        if (getBaseActivity() != null) {
//            getBaseActivity().showLightLoadingDialogWithDelay(msg,delayMillis);
//        }
//    }
}
