package com.alipictures.cozyadapter.sdk.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.alipictures.cozyadapter.sdk.action.OnItemActionListener;
import com.alipictures.cozyadapter.sdk.vh.AbsRecyclerViewHolder;
import com.alipictures.cozyadapter.sdk.vh.BaseViewHolder;
import com.alipictures.cozyadapter.sdk.vh.ViewHolder;
import com.alipictures.cozyadapter.sdk.vm.BaseViewModel;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by pengfei on 16/12/16.
 */
public class CozyRecyclerAdapter<VM extends BaseViewModel, VH extends AbsRecyclerViewHolder> extends AbsRecyclerAdapter<VM, VH> {

    protected List<Class> itemTypes = new ArrayList<Class>();

    private OnItemActionListener listener;

    protected OnItemActionListener internalListner = new OnItemActionListener() {
        @Override
        public void onItemClick(BaseViewHolder baseViewHolder, View v, int position, Object data) {
            if (listener != null) {
                listener.onItemClick(baseViewHolder, v, position, getItem(position));
            }
        }

        @Override
        public void onItemLongClick(BaseViewHolder baseViewHolder, View v, int position, Object data) {
            if (listener != null) {
                listener.onItemLongClick(baseViewHolder, v, position, getItem(position));
            }
        }

        @Override
        public void onEvent(int eventId, BaseViewHolder baseViewHolder, View v, int position, Object data) {
            if (listener != null) {
                listener.onEvent(eventId, baseViewHolder, v, position, getItem(position));
            }
        }
    };

    public CozyRecyclerAdapter(Context context) {
        super(context);
    }

    @Override
    public void setDataList(List<VM> dataList) {
        removeAllItems();
        addItems(dataList);
    }

    @Override
    public void appendDataList(List<VM> dataList) {
        addItems(dataList);
    }

    public void addItem(VM item) {
        if (!itemTypes.contains(item.getClass())) {
            itemTypes.add(item.getClass());
        }
        if (mDataList == null) {
            mDataList = new ArrayList<>();
        }
        mDataList.add(item);
        notifyItemInserted(mDataList.size() - 1);
    }

    public void addItems(List<VM> items) {
        if (items == null || items.size() == 0) {
            return;
        }
        if (mDataList == null) {
            mDataList = new ArrayList<>();
        }
        int start = mDataList.size();
        for (VM item: items) {
            if (!itemTypes.contains(item.getClass())) {
                itemTypes.add(item.getClass());
            }
            mDataList.add(item);
        }
        notifyItemRangeInserted(start, items.size());
    }

    public void removeItem(VM item) {
        int position = -1;
        if (mDataList != null && mDataList.contains(item)) {
            position = mDataList.indexOf(item);
        }
        if (position != -1 && mDataList.remove(item)) {
            notifyItemRemoved(position);
        }
    }

    public void removeItem(int position) {
        if (mDataList != null && position >= 0 && position < mDataList.size() - 1) {
            VM item = mDataList.get(position);
            if (mDataList.remove(item)) {
                notifyItemRemoved(position);
            }
        }
    }

    public void removeAllItems() {
        if (mDataList != null) {
            int size = mDataList.size();
            mDataList.clear();
            notifyItemRangeRemoved(0, size);
        }
    }

    public List<VM> getItemList() {
        return this.mDataList;
    }

    @Override
    public int getItemViewType(int position) {
        VM item = getItem(position);
        return itemTypes.indexOf(item.getClass());
    }

    @Override
    public final VH createViewHolder(Context context, ViewGroup viewGroup, int viewType) {

        return null;
    }

    @Override
    public VH onCreateViewHolder(ViewGroup viewGroup, int viewType) {
        if (viewType < 0 || viewType >= itemTypes.size()) {
            return null;
        }
        Class clz = itemTypes.get(viewType);
        Class vhClz = findBindViewHolderClz(clz);

        // way 1: reflect static method
        VH viewHolder = null;
        try {
            Method method = vhClz.getDeclaredMethod("newInstance", Context.class, ViewGroup.class);
            method.setAccessible(true);
            viewHolder = (VH) method.invoke(null, mContext, viewGroup);
            viewHolder.setActionListener(internalListner);
        } catch (NoSuchMethodException e) {
            //e.printStackTrace();
        } catch (InvocationTargetException e) {
            //e.printStackTrace();
        } catch (IllegalAccessException e) {
            //e.printStackTrace();
        }

        // way 2: reflect annotations
        if (viewHolder == null && vhClz.isAnnotationPresent(ViewHolder.class)) {
            ViewHolder annotation = (ViewHolder) vhClz.getAnnotation(ViewHolder.class);
            int layoutId = annotation.layoutId();
            View view = LayoutInflater.from(mContext).inflate(layoutId, viewGroup, false);
            try {
                Constructor<? extends BaseViewHolder> constructor = vhClz.getConstructor(View.class);
                constructor.setAccessible(true);
                viewHolder = (VH) constructor.newInstance(view);
                viewHolder.setActionListener(internalListner);
            } catch (NoSuchMethodException e) {
                //e.printStackTrace();
            } catch (InvocationTargetException e) {
                //e.printStackTrace();
            } catch (InstantiationException e) {
                //e.printStackTrace();
            } catch (IllegalAccessException e) {
                //e.printStackTrace();
            }
        }

        return viewHolder;

    }

    /**
     * 根据class获得绑定的ViewHolder
     *
     * @param clz
     * @return
     */
    private Class findBindViewHolderClz(Class clz) {
        if (clz == null)
            return null;
        //自己的范型
        clz.getTypeParameters();
        //先找父类实现的范行
        Type superClzType = clz.getGenericSuperclass();
        if (superClzType == null)
            return null;
        if (superClzType instanceof ParameterizedType) {
            Class targetClz = findBindViewHolderWithParameterizedType((ParameterizedType) superClzType);
            if (targetClz != null)
                return targetClz;
        }

        Type[] interfaceTypes = clz.getGenericInterfaces();
        if (interfaceTypes != null && interfaceTypes.length > 0) {
            for (Type type : interfaceTypes) {
                if (type instanceof ParameterizedType) {
                    Class targetClz = findBindViewHolderWithParameterizedType((ParameterizedType) type);
                    if (targetClz != null)
                        return targetClz;
                }
            }
        }
        //都没有的话递归父类m
        return findBindViewHolderClz(clz.getSuperclass());
    }

    private Class findBindViewHolderWithParameterizedType(ParameterizedType parameterizedType) {
        Type[] argumentTypes = parameterizedType.getActualTypeArguments();

        for (Type type : argumentTypes) {
            if ((type instanceof Class) && RecyclerView.ViewHolder.class.isAssignableFrom((Class) type)) {
                return (Class) type;
            }
        }
        return null;
    }

    public void setOnItemActionListener(OnItemActionListener listener) {
        this.listener = listener;
    }

//    protected AbsRecyclerActionRouter createActionRouter(AbsRecyclerViewHolder viewHolder) {
//        return new DefaultRecyclerActionRouter(mItemActionListener, viewHolder);
//    }
}
