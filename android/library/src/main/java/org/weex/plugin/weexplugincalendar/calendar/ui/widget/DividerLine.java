package org.weex.plugin.weexplugincalendar.calendar.ui.widget;

import android.graphics.Canvas;
import android.graphics.Paint;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;


public class DividerLine extends RecyclerView.ItemDecoration {
    /**
     * 水平方向
     */
    public static final int HORIZONTAL = LinearLayoutManager.HORIZONTAL;

    /**
     * 垂直方向
     */
    public static final int VERTICAL = LinearLayoutManager.VERTICAL;

    // 画笔
    private Paint paint;

    // 布局方向
    private int orientation;
    // 分割线颜色
    private int color;
    // 分割线尺寸
    private int size;

    //两边间距
    private int endPadding;

    public DividerLine() {
        this(VERTICAL);
    }

    public DividerLine(int orientation) {
        this.orientation = orientation;

        paint = new Paint();
    }

    @Override
    public void onDrawOver(Canvas c, RecyclerView parent, RecyclerView.State state) {
        super.onDrawOver(c, parent, state);

        if (orientation == VERTICAL) {
            drawHorizontal(c, parent);
        } else {
            drawVertical(c, parent);
        }
    }

    /**
     * 设置分割线颜色
     *
     * @param color 颜色
     */
    public void setColor(int color) {
        this.color = color;
        paint.setColor(color);
    }

    /**
     * 设置分割线尺寸
     *
     * @param size 尺寸
     */
    public void setSize(int size) {
        this.size = size;
    }


    /**
     * 设置两头间距
     *
     * @param endPadding 尺寸
     */
    public void setEndPadding(int endPadding) {
        this.endPadding = endPadding;
    }

    // 绘制垂直分割线
    protected void drawVertical(Canvas c, RecyclerView parent) {
        final int top = parent.getPaddingTop() + endPadding;
        final int bottom = parent.getHeight() - parent.getPaddingBottom() - endPadding;

        final int childCount = parent.getChildCount();
        //最后一个item不要分割线
        for (int i = 0; i < childCount - 1; i++) {
            final View child = parent.getChildAt(i);
            final RecyclerView.LayoutParams params = (RecyclerView.LayoutParams) child.getLayoutParams();
            final int left = child.getRight() + params.rightMargin;
            final int right = left + size;

            c.drawRect(left, top, right, bottom, paint);
        }
    }

    // 绘制水平分割线
    protected void drawHorizontal(Canvas c, RecyclerView parent) {
        final int left = parent.getPaddingLeft() + endPadding;
        final int right = parent.getWidth() - parent.getPaddingRight() - endPadding;

        final int childCount = parent.getChildCount();
        //最后一个item不要分割线
        for (int i = 0; i < childCount - 1; i++) {
            final View child = parent.getChildAt(i);
            final RecyclerView.LayoutParams params = (RecyclerView.LayoutParams) child.getLayoutParams();
            final int top = child.getBottom() + params.bottomMargin;
            final int bottom = top + size;

            c.drawRect(left, top, right, bottom, paint);
        }
    }
}
