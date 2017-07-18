package org.weex.plugin.weexplugincalendar.calendar.ui;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TabLayout;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;

import org.weex.plugin.weexplugincalendar.R;
import org.weex.plugin.weexplugincalendar.calendar.CalendarOptions;
import org.weex.plugin.weexplugincalendar.calendar.CalendarPickerHelper;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarConfig;
import org.weex.plugin.weexplugincalendar.calendar.model.CalendarHeader;
import org.weex.plugin.weexplugincalendar.calendar.ui.widget.BaseTitleBar;
import org.weex.plugin.weexplugincalendar.calendar.ui.widget.BaseTitleOption;


/**
 * Created by pengfei on 17/2/27.
 */

public class CalendarPickerActivity extends FragmentActivity implements View.OnClickListener {

    static CalendarConfig config;

    static int presaleDays;

    /** @ViewBind 注解子类无法享受到，父类用@ViewBind注解的控件，子类拿到都是null */
    //@ViewBind(R.id.tab_layout_calendar_picker)
    TabLayout tabLayout;

    //@ViewBind(R.id.pager_calendar_fragmaents)
    ViewPager pager;

    CalendarPagerAdapter adapter;

    private int currentTabIndex = 0;

    private CalendarOptions options;

    private Bundle params;

    private CalendarHeader [] defaultHeaders = new CalendarHeader[] {
            CalendarHeader.HEADER_DAY,
            CalendarHeader.HEADER_WEEK,
            CalendarHeader.HEADER_MONTH,
            CalendarHeader.HEADER_YEAR,
            CalendarHeader.HEADER_PERIOD,
            CalendarHeader.HEADER_CUSTOM
    };

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_calendar_picker);
        tabLayout = (TabLayout) findViewById(R.id.tab_layout_calendar_picker);
        pager = (ViewPager) findViewById(R.id.pager_calendar_fragmaents);
        initParams(getIntent());
        initPager();
        initTabLayout();

//        if (options.screenOrientation == ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE) {
//            setRequestedOrientation(options.screenOrientation);
//        }
    }

    protected void initTitleBar( ) {
        BaseTitleBar titleBar = (BaseTitleBar) LayoutInflater.from(this).inflate(R.layout.view_base_titlebar, null);

        if (titleBar != null) {
            BaseTitleOption.Builder builder = new BaseTitleOption.Builder();
            BaseTitleOption option = builder.setCenterContent(getString(R.string.title_calendar_picker))
                    .setLeftContent(getString(R.string.btn_close)).setLeftClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            setResult(RESULT_CANCELED);
                            finish();
                            notifyCancel();
                        }
                    }).build();
            titleBar.setBaseTitleBarOption(option);
        }
    }

    private void notifyCancel() {
        CalendarPickerHelper.OnResultListener listener = CalendarPickerHelper.getInstance().getResultListener();
        if (listener != null) {
            listener.onCancel();
        }
        CalendarPickerHelper.getInstance().setResultListener(null);
        CalendarPickerHelper.getInstance().setStarted(false);
    }

    private void initParams(Intent intent) {
        if (intent == null) {
            return;
        }
        params = intent.getExtras();
        options = intent.getParcelableExtra(CalendarPickerHelper.EXTRA_OPTION);
        //getConfig(options.bizType);
    }

//    private void getConfig(int bizType) {
//        CalendarConfigMo configMo = new CalendarMovieProMovieproConfig().get();
//        switch (bizType) {
//            case BizType.BIZ_BOXOFFICE:
//                config = configMo.boxofficeConfig;
//                break;
//            case BizType.BIZ_SCHEDULE:
//                config = configMo.scheduleConfig;
//                break;
//            case BizType.BIZ_CINEMA:
//                config = configMo.cinemaConfig;
//                break;
//            case BizType.BIZ_SHOW:
//                config = configMo.filmConfig;
//                break;
//            default:
//                config = configMo.boxofficeConfig;
//                break;
//        }
//        presaleDays = configMo.presaleDays;
//
//        LogUtil.d("Cal", "getConfig/in bizType:" + bizType + " config:" + config);
//    }

    private void initTabLayout() {
        if (adapter.getCount() == 1) {
            tabLayout.setVisibility(View.GONE);
            return;
        }
        tabLayout.setVisibility(View.VISIBLE);
        tabLayout.setupWithViewPager(pager);
//        int pageCnt = pager.getAdapter().getCount();
//        int screenWidth = DisplayUtil.getScreenWidth(this);
//        int tabWidth;
//        if (pageCnt <= 4) {
//            tabWidth = screenWidth / 4;
//        } else {
//            tabWidth = (int) (screenWidth / 4.5f);
//        }
//        LogUtil.d("wpf", "initTabLayout/in pageCount:" + pageCnt + " width:" + screenWidth + " tab:" + tabWidth + " cnt:" + tabLayout.getChildCount());
//        for (int i = 0; i < pageCnt; i++) {
//            TabLayout.Tab tab = tabLayout.getTabAt(i);
//            View view = tab.getCustomView();
//            LogUtil.d("wpf", "initTabLayout view:" + view );
//            if (view != null) {
//                ViewGroup.LayoutParams params = view.getLayoutParams();
//                params.width = tabWidth;
//                view.setLayoutParams(params);
//            }
//        }
        tabLayout.setOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                pager.setCurrentItem(tab.getPosition(), true);
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });
    }

    private void initPager() {
        if (pager == null) {
            return;
        }
        adapter = new CalendarPagerAdapter(getSupportFragmentManager(), this, params);
        CalendarHeader [] headers = null;
        if (options != null) {
            headers = options.headers;
        }
        if (headers == null) {
            headers = defaultHeaders;
        }
        adapter.setHeaders(headers);
        pager.setAdapter(adapter);
        pager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                if (currentTabIndex != position) {
                    currentTabIndex = position;
                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
        if (options != null && options.currentModel != null) {
            selectTab(options.currentModel.type);
        }
    }

    private void selectTab(int type) {
        int position = 0;
        if (options.headers != null) {
            for (int i = 0; i < options.headers.length; i++) {
                if (options.headers[i].type == type) {
                    position = i;
                    break;
                }
            }
            pager.setCurrentItem(position, false);
        }
    }

    @Override
    public void onClick(View v) {

    }

    @Override
    public void onBackPressed() {
        notifyCancel();
        super.onBackPressed();
    }

//    @Override
//    protected int getExitAnimation() {
//        return R.anim.slide_out_bottom;
//    }
//
//    @Override
//    protected int getEnterAnimation() {
//        return R.anim.slide_in_bottom;
//    }
}
