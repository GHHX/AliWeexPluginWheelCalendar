package org.weex.plugin.weexplugincalendar.calendar.vm;

import android.view.View;

/**
 * Created by pengfei on 17/3/1.
 */

public interface OnItemActionListener<T extends BaseSubYearViewHolder> {

    void onItemClick(T t, View v, int position, Object data);


}
