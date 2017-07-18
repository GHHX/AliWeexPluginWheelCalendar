package org.weex.plugin.weexplugincalendar.calendar.ui.widget;

import android.animation.ObjectAnimator;
import android.content.Context;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import org.weex.plugin.weexplugincalendar.R;


/**
 * BaseTitleBar
 * <p>
 * <p>
 * 对应的xml: view_base_titlebar.xml
 *
 * @author 卫晨(wenwei.ww@alibaba-inc.com)
 * @version 17/2/20
 */
public class BaseTitleBar extends RelativeLayout {

    private TextView tvDebugInfo;

    private View vLeftHolder = null;

    private TextView tvleft = null;

    private TextView tvCenter = null;

    private ImageView ivCenter = null;

    private View vDivideLine = null;

    private View vRightHolder = null;

    private View vCenterHolder = null;

    private TextView tvRight1 = null;

    private TextView tvRight2 = null;

    private ObjectAnimator mCurrentShowAnim;


    /**
     * 用于中间通用点击, 中间部分可以设置两个点击事件
     */
    private OnClickListener centerCommonClickListener;

    private OnClickListener centerClickListener;

    private OnClickListener innerCenterCommonClickListener = new OnClickListener() {
        @Override
        public void onClick(View v) {
            if (centerCommonClickListener != null) {
                centerCommonClickListener.onClick(v);
            }

            if (centerClickListener != null) {
                centerClickListener.onClick(v);
            }
        }
    };

    private boolean isShowing = false;

    public BaseTitleBar(Context context) {
        super(context);
    }

    public BaseTitleBar(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public BaseTitleBar(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    public static BaseTitleBar createView(Context context) {
        return createView(context, null);
    }

    public static BaseTitleBar createView(Context context, ViewGroup parent) {
        return (BaseTitleBar) LayoutInflater.from(context).inflate(R.layout.view_base_titlebar, parent, false);
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        initViews();
    }


    private void initViews() {

        vLeftHolder = findViewById(R.id.v_base_title_bar_left_holder);
        tvleft = (TextView) findViewById(R.id.v_base_title_bar_left);
        tvCenter = (TextView) findViewById(R.id.tv_base_title_center);
        vRightHolder = findViewById(R.id.v_base_title_bar_right_holder);
        tvRight1 = (TextView) findViewById(R.id.tv_title_bar_right_1);
        tvRight2 = (TextView) findViewById(R.id.tv_title_bar_right_2);
        ivCenter = (ImageView) findViewById(R.id.iv_base_title_center);
        vDivideLine = findViewById(R.id.v_base_title_bar_divider);
        vCenterHolder = findViewById(R.id.base_title_bar_center_holder);
        tvDebugInfo = (TextView) findViewById(R.id.tv_debug);

        tvDebugInfo.setVisibility(GONE);
    }


    /**
     * 用于中间通用点击, 中间部分可以设置两个点击事件
     */
    public void setCenterCommonClickListener(OnClickListener listener) {
        this.centerCommonClickListener = listener;
        if(vCenterHolder!=null) {
            vCenterHolder.setOnClickListener(innerCenterCommonClickListener);
        }
    }

    public void setBaseTitleBarOption(BaseTitleOption option) {

        if (option == null) {
            throw new NullPointerException(BaseTitleOption.class.getName()
                    + "BaseTitleOption cannot be null!!!!");
        }
        //left
        if (!TextUtils.isEmpty(option.getTitleleftContent())) {
            //有左侧文字，显示
            tvleft.setVisibility(View.VISIBLE);
            tvleft.setText(option.getTitleleftContent());
        } else {
            tvleft.setVisibility(View.INVISIBLE);
        }

        //左边按钮
        OnClickListener leftClickListener = option.getLeftClickListener();

        if (leftClickListener != null) {
            tvleft.setOnClickListener(leftClickListener);
        }

        //右边按钮1
        if (!TextUtils.isEmpty(option.getTitleRight1Content())) {//有右侧文字，显示
            tvRight1.setVisibility(View.VISIBLE);
            tvRight1.setText(option.getTitleRight1Content());
        } else {
            tvRight1.setVisibility(View.INVISIBLE);
        }
        //右边按钮1
        OnClickListener rightClickListener = option.getRight1ClickListener();

        if (rightClickListener != null) {
            tvRight1.setOnClickListener(rightClickListener);
        }


        //右边按钮2
        if (!TextUtils.isEmpty(option.getTitleRight2Content())) {//有右侧文字，显示
            tvRight2.setVisibility(View.VISIBLE);
            tvRight2.setText(option.getTitleRight2Content());
        } else {
            tvRight2.setVisibility(View.INVISIBLE);
        }
        //右边按钮2
        OnClickListener right2ClickListener = option.getRight2ClickListener();

        if (right2ClickListener != null) {
            tvRight2.setOnClickListener(right2ClickListener);
        }

        //中间部分
        if (!TextUtils.isEmpty(option.getTitleContent())) {
            //中间文字，显示
            tvCenter.setVisibility(View.VISIBLE);
            ivCenter.setVisibility(View.INVISIBLE);
            tvCenter.setText(option.getTitleContent());
        } else if (option.getTitleCenterIcon() != 0) {

            tvCenter.setVisibility(View.INVISIBLE);
            ivCenter.setVisibility(View.VISIBLE);
            ivCenter.setImageResource(option
                    .getTitleCenterIcon());
        } else {
            tvCenter.setVisibility(View.INVISIBLE);
            ivCenter.setVisibility(View.INVISIBLE);
        }

        //中间阿牛
        OnClickListener centerClickListener = option.getCenterClickListener();

        this.centerClickListener = centerClickListener;

        if (centerClickListener != null) {
            vCenterHolder.setOnClickListener(innerCenterCommonClickListener);
        }

    }

    public void setDebugInfo(String info) {
        tvDebugInfo.setVisibility(TextUtils.isEmpty(info) ? View.GONE : View.VISIBLE);
        tvDebugInfo.setText(info);
    }


    public void hide() {
        doHide();
    }

    public void show() {
        doShow();
    }

    public boolean isShowing() {
        return isShowing;
    }

    private void doShow() {
        if (this.mCurrentShowAnim != null) {
            this.mCurrentShowAnim.cancel();
        }
        isShowing = true;
        mCurrentShowAnim = ObjectAnimator.ofFloat(this, "translationY", getTranslationY(), 0).setDuration(1000);
        mCurrentShowAnim.start();
        offsetTopAndBottom(0);

    }

    private void doHide() {
        if (this.mCurrentShowAnim != null) {
            this.mCurrentShowAnim.cancel();
        }
        isShowing = false;
        mCurrentShowAnim = ObjectAnimator.ofFloat(this, "translationY", 0, -getHeight()).setDuration(1000);
        mCurrentShowAnim.start();
        offsetTopAndBottom(-1000);
    }

    public void setDividerLineVisiable(boolean visiable) {
        if (vDivideLine != null) {
            vDivideLine.setVisibility(visiable ? VISIBLE : INVISIBLE);
        }
    }

    public TextView getTvRight1() {
        return tvRight1;
    }

    public TextView getTvRight2() {
        return tvRight2;
    }

    public TextView getTvLeft() {
        return tvleft;
    }

    public void setTitle(String title) {
        if (!TextUtils.isEmpty(title)) {
            this.tvCenter.setVisibility(View.VISIBLE);
            this.tvCenter.setText(title);
        }
    }
}
