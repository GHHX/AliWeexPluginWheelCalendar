package org.weex.plugin.weexplugincalendar.calendar.ui.widget;


import android.view.View.OnClickListener;

import org.weex.plugin.weexplugincalendar.R;


/**
 * BaseTitleOption
 * <p>
 *
 * @author 卫晨(wenwei.ww@alibaba-inc.com)
 * @version 17/2/20
 */
public class BaseTitleOption {

    private String titleleftContent;

    private int titleCenterIcon;

    private String titleContent;

    private String titleRight1Content;

    private String titleRight2Content;

    private OnClickListener leftClickListener;

    private OnClickListener right1ClickListener;

    private OnClickListener right2ClickListener;

    private OnClickListener centerClickListener;


    public BaseTitleOption(Builder builder) {
        this.titleleftContent = builder.titleleftContent;
        this.titleCenterIcon = builder.titleCenterIcon;
        this.titleContent = builder.titleContent;
        this.titleRight1Content = builder.titleRight1Content;
        this.titleRight2Content = builder.titleRight2Content;

        this.leftClickListener = builder.leftClickListener;
        this.right1ClickListener = builder.right1ClickListener;
        this.right2ClickListener = builder.right2ClickListener;
        this.centerClickListener = builder.centerClickListener;
    }

    public String getTitleleftContent() {
        return titleleftContent;
    }

    public void setTitleleftContent(String titleleftContent) {
        this.titleleftContent = titleleftContent;
    }


    public int getTitleCenterIcon() {
        return titleCenterIcon;
    }

    public void setTitleCenterIcon(int titleCenterIcon) {
        this.titleCenterIcon = titleCenterIcon;
    }

    public String getTitleContent() {
        return titleContent;
    }

    public void setTitleContent(String titleContent) {
        this.titleContent = titleContent;
    }

    public String getTitleRight1Content() {
        return titleRight1Content;
    }

    public void setTitleRight1Content(String titleRight1Content) {
        this.titleRight1Content = titleRight1Content;
    }

    public String getTitleRight2Content() {
        return titleRight2Content;
    }

    public void setTitleRight2Content(String titleRight2Content) {
        this.titleRight2Content = titleRight2Content;
    }

    public OnClickListener getLeftClickListener() {
        return leftClickListener;
    }

    public void setLeftClickListener(OnClickListener leftClickListener) {
        this.leftClickListener = leftClickListener;
    }

    public OnClickListener getRight1ClickListener() {
        return right1ClickListener;
    }

    public void setRight1ClickListener(OnClickListener right1ClickListener) {
        this.right1ClickListener = right1ClickListener;
    }

    public OnClickListener getRight2ClickListener() {
        return right2ClickListener;
    }

    public void setRight2ClickListener(OnClickListener right2ClickListener) {
        this.right2ClickListener = right2ClickListener;
    }

    public OnClickListener getCenterClickListener() {
        return centerClickListener;
    }

    public void setCenterClickListener(OnClickListener centerClickListener) {
        this.centerClickListener = centerClickListener;
    }

    public enum BaseTitleResource {

        //FIXME
        LEFT_ICONFONT_BACK(R.string.app_name);

        private int resId;

        BaseTitleResource(int resid) {
            this.resId = resid;
        }

        public int getResId() {
            return resId;
        }
    }

    public static class Builder {

        private String titleleftContent;

        private int titleCenterIcon;

        private String titleContent;

        private String titleRight1Content;

        private String titleRight2Content;

        private OnClickListener leftClickListener;

        private OnClickListener right1ClickListener;

        private OnClickListener right2ClickListener;

        private OnClickListener centerClickListener;


        public Builder setLeftContent(String content) {
            titleleftContent = content;
            return this;
        }

        public Builder setRight1Content(String content) {
            titleRight1Content = content;
            return this;
        }

        public Builder setRight2Content(String content) {
            titleRight2Content = content;
            return this;
        }

        public Builder setCenterIcon(int resid) {
            titleCenterIcon = resid;
            return this;
        }

        public Builder setCenterContent(String content) {
            titleContent = content;
            return this;
        }

        public Builder setLeftClickListener(OnClickListener listener) {
            leftClickListener = listener;
            return this;
        }

        public Builder setRight1ClickListener(OnClickListener listener) {
            right1ClickListener = listener;
            return this;
        }

        public Builder setRight2ClickListener(OnClickListener listener) {
            right2ClickListener = listener;
            return this;
        }

        public Builder setCenterClickListener(OnClickListener listener) {
            centerClickListener = listener;
            return this;
        }

        public BaseTitleOption build() {
            return new BaseTitleOption(this);
        }

    }
}
