package com.alipictures.cozyadapter.sdk.vh;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by pengfei on 16/9/26.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface ViewHolder {

//    /**
//     * ViewHolder映射的ViewType
//     * @return
//     */
//    int viewType() default MessageVM.MSG_TYPE_SYSTEM;

    /**
     * ViewHolder 对应的layout id
     */
    int layoutId() default 0;

//    /**
//     * ViewHolder 关联对象的生成器
//     */
//   public Class<? extends ViewHolderCreator> generate() default DefaultViewHolderCreator.class;


}
