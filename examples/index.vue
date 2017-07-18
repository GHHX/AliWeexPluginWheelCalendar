<template>
	<div class="conatiner">
		<text style="margin-bottom: 20px;" >weex plugin calendar examplessss:</text>
		<div @click="startCalendar(0)" style="margin: 20px;padding:20px;background-color:#1ba1e2;color:#fff;">
			<text test-id="btn_single" style="color:#fff">Start Calendar(Single)</text>
		</div>

		<div @click="startCalendar(1)" style="margin: 20px;padding:20px;background-color:#1ba1e2;color:#fff;"><text style="color:#fff">Start Calendar(Multiple)</text></div>

		<text>Result:</text>
		<text>{{resultTxt}}</text>
	</div>
</template>

<style>
	.container{
		flex: 1;
	}
</style>

<script>

	const calendar = weex.requireModule('weexPluginCalendar');
	module.exports = {
		data: {
			resultTxt: '',
		},

		mounted: function () {
			this.runTestSuite();
        },
		methods: {
            success : function(testCase, msg) {
				this.resultTxt +="\n[SUCCESS] ";
				this.resultTxt += (testCase + " ");
				if (msg) {
                    this.resultTxt += msg;
                }
            },
		    fail : function(testCase, msg) {
                this.resultTxt += "\n" + "[FAIL] ";
                this.resultTxt += testCase + " ";
                if (msg) {
                    this.resultTxt += msg;
				}
			},
			runTestSuite : function () {
                this.test_getNextDate_1();
                this.test_getNextDate_2();
                this.test_getNextDate_3();
                this.test_getNextDate_4();
                this.test_getNextDate_5();
                this.test_getNextDate_6();
                this.test_getNextDate_7();
                this.test_getNextDate_8();
            },
            startCalendar: function(mode) { // 0：单选；1：区间多选

                let params = {

                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 28, // 该天，必填
                            week: 0, // 该日所属的周，日期类型为周必填
                            month: 2, // 该日所属月份，必填
                            period: 0, // 该日所属档期，保留字段，未使用。可不填
                            year: 2017, // 该日所属年，必填
                            weekYear: 2017, // 该日所属的周所在的年，周跨年时该字段可能与year不同，日期类型为周必填
                            periodYear: 2017 // 该日所属档期所在的年，档期跨年时该字段可能与year不同，日期类型为档期必填
                        },
                        end: {
                            day: 4,
                            week: 0,
                            month: 3,
                            period: 0,
                            year: 2017,
                            weekYear: 2017,
                            periodYear: 2017
                        },
                        type: 0, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：自定义。必填
                        dateAlias: '春节档'
                    },
                    headers: [{
                        name: '日单选', // 日历选择tab的显示名称
                        type: 0, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                        mode: 0 // 选择模式，0：单选；1：区间多选；
                    }, {
                        name: '周单选',
                        type: 1,
                        mode: 0
                    }, {
                        name: '月单选',
                        type: 2,
                        mode: 0
                    }, {
                        name: '年单选',
                        type: 4,
                        mode: 0
                    }, {
                        name: '日多选',
                        type: 6,
                        mode: 0
                    }],
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        maxDays: 90, // 【仅多选用】日多选最大间隔天数
                        maxWeeks: 60, // 【仅多选用】周多选最大间隔周数
                        maxMoths: 12, // 【仅多选用】月多选最大间隔月数，单词month拼错了，为兼容，就让他错下去
                        maxYears: 10, // 【仅多选用】年多选最大间隔年数
                        singleDayDelta: 15, // 【可为空，默认0】日单选结束日期和今天的差值，如需要预售15天，设置为15
                        rangeDayDelta: -1, // 【可为空，默认0】日多选结束日期和今天的差值，如果需要显示到昨天，设置为-1
                        weekDelta: 1, // 【可为空，默认0】周结束日期和本周的差值，如需要显示到下周，设置为1
                        monthDelta: 1, // 【可为空，默认0】月结束日期和本月的差值，如果需要显示到下月，设置为1
                        yearDelta: 0, // 【可为空，默认0】年结束日期和今天的差值，如需要显示到今年，设置为0
                        periodDelta: 1, // 【可为空，默认0】档期结束日期和今年的差值，如果需要显示到明年的档期，设置为1
                        currentTs: 1497834000000, // 2017.6.19 【可为空，默认取本地时间】当前时间，如果不传使用本地时间
                    }
                };

                if (mode == 1) {
                    params.headers = [
                        {
                            name: '日多选',
                            type: 6,
                            mode: 0
                        }, {
                            name: '周多选',
                            type: 1,
                            mode: 1
                        }, {
                            name: '月多选',
                            type: 2,
                            mode: 1
                        }, {
                            name: '年多选',
                            type: 4,
                            mode: 1
                        }
					];
				}

                calendar.startCalendar(params, (date)=> {
                    this.resultTxt = JSON.stringify(date, null, 4);
                });

			},

            test_getNextDate_1: function() {

                let params = {

                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 28, // 该天，必填
                            week: 0, // 该日所属的周，日期类型为周必填
                            month: 2, // 该日所属月份，必填
                            period: 0, // 该日所属档期，保留字段，未使用。可不填
                            year: 2017, // 该日所属年，必填
                            weekYear: 2017, // 该日所属的周所在的年，周跨年时该字段可能与year不同，日期类型为周必填
                        },
                        end: {
                            day: 28,
                            week: 0,
                            month: 2,
                            period: 0,
                            year: 2017,
                            weekYear: 2017,
                        },
                        type: 0, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                    },
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        maxDays: 90, // 【仅多选用】日多选最大间隔天数
                        maxWeeks: 60, // 【仅多选用】周多选最大间隔周数
                        maxMoths: 12, // 【仅多选用】月多选最大间隔月数，单词month拼错了，为兼容，就让他错下去
                        maxYears: 10, // 【仅多选用】年多选最大间隔年数
                        singleDayDelta: 15, // 【可为空，默认0】日单选结束日期和今天的差值，如需要预售15天，设置为15
                        rangeDayDelta: -1, // 【可为空，默认0】日多选结束日期和今天的差值，如果需要显示到昨天，设置为-1
                        weekDelta: 1, // 【可为空，默认0】周结束日期和本周的差值，如需要显示到下周，设置为1
                        monthDelta: 1, // 【可为空，默认0】月结束日期和本月的差值，如果需要显示到下月，设置为1
                        yearDelta: 0, // 【可为空，默认0】年结束日期和今天的差值，如需要显示到今年，设置为0
                        periodDelta: 1, // 【可为空，默认0】档期结束日期和今年的差值，如果需要显示到明年的档期，设置为1
                        currentTs: 1497834000000 // 2017.6.19 // 【可为空，默认取本地时间】当前时间，如果不传使用本地时间
                    }
                };


                calendar.getNextDate(params, (date)=> {
                    if (date == null) {
						this.fail("test_getNextDate_1");
					} else {
                        this.success("test_getNextDate_1");
					}
                });

            },

            test_getNextDate_2: function() {
                let params = {
                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 19, // 该天，必填
                            month: 6, // 该日所属月份，必填
                            year: 2017, // 该日所属年，必填
                        },
                        end: {
                            day: 19,
                            month: 6,
                            year: 2017,
                        },
                        type: 0, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                    },
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        singleDayDelta: 0, // 【可为空，默认0】日单选结束日期和今天的差值，如需要预售15天，设置为15
                        currentTs: 1497834000000, // 2017.6.19
                    }
                };

                calendar.getNextDate(params, (date)=> {
                    if (date && date.start && date.end) {
                        this.fail("test_getNextDate_2", JSON.stringify(date, null, 4));
                    } else {
                        this.success("test_getNextDate_2");
                    }
                });
            },

            test_getNextDate_3: function() { // has next week
                let params = {
                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 12, // 该天，必填
                            month: 6, // 该日所属月份，必填
							week: 24,
                            year: 2017, // 该日所属年，必填
							weekYear: 2017
                        },
                        end: {
                            day: 18,
                            month: 6,
							week: 24,
                            year: 2017,
							weekYear: 2017
                        },
                        type: 1, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                    },
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        currentTs: 1497834000000, // 2017.6.19
                    }
                };

                calendar.getNextDate(params, (date)=> {
                    if (date && date.start && date.end) {
                        this.success("test_getNextDate_3");
                    } else {
                        this.fail("test_getNextDate_3", JSON.stringify(date, null, 4));
                    }
                });
            },

            test_getNextDate_4: function() { // no next week
                let params = {
                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 19, // 该天，必填
                            month: 6, // 该日所属月份，必填
                            week: 25,
                            year: 2017, // 该日所属年，必填
                            weekYear: 2017
                        },
                        end: {
                            day: 25,
                            month: 6,
                            week: 25,
                            year: 2017,
                            weekYear: 2017
                        },
                        type: 1, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                    },
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        currentTs: 1497834000000, // 2017.6.19
                    }
                };

                calendar.getNextDate(params, (date)=> {
                    if (date && date.start && date.end) {
                        this.fail("test_getNextDate_4", JSON.stringify(date, null, 4));
                    } else {
                        this.success("test_getNextDate_4");
                    }
                });
            },

            test_getNextDate_5: function() { // has next month
                let params = {
                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 1, // 该天，必填
                            month: 5, // 该日所属月份，必填
                            year: 2017, // 该日所属年，必填
                        },
                        end: {
                            day: 31,
                            month: 5,
                            year: 2017,
                        },
                        type: 2, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                    },
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        currentTs: 1497834000000, // 2017.6.19
                    }
                };

                calendar.getNextDate(params, (date)=> {
                    if (date && date.start && date.end) {
                        this.success("test_getNextDate_5");
                    } else {
                        this.fail("test_getNextDate_5", JSON.stringify(date, null, 4));
                    }
                });
            },

            test_getNextDate_6: function() { // no next month
                let params = {
                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 1, // 该天，必填
                            month: 6, // 该日所属月份，必填
                            year: 2017, // 该日所属年，必填
                        },
                        end: {
                            day: 30,
                            month: 6,
                            year: 2017,
                        },
                        type: 2, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                    },
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        currentTs: 1497834000000, // 2017.6.19
                    }
                };

                calendar.getNextDate(params, (date)=> {
                    if (date && date.start && date.end) {
                        this.fail("test_getNextDate_6", JSON.stringify(date, null, 4));
                    } else {
                        this.success("test_getNextDate_6");
                    }
                });
            },

            test_getNextDate_7: function() { // has next year
                let params = {
                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 1, // 该天，必填
                            month: 1, // 该日所属月份，必填
                            year: 2016, // 该日所属年，必填
                        },
                        end: {
                            day: 31,
                            month: 12,
                            year: 2016,
                        },
                        type: 4, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                    },
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        currentTs: 1497834000000, // 2017.6.19
                    }
                };

                calendar.getNextDate(params, (date)=> {
                    if (date && date.start && date.end) {
                        this.success("test_getNextDate_7");
                    } else {
                        this.fail("test_getNextDate_7", JSON.stringify(date, null, 4));
                    }
                });
            },

            test_getNextDate_8: function() { // no next year
                let params = {
                    currentModel: {
                        start: { // 代表一日，如为日单选，则start和end相同
                            day: 1, // 该天，必填
                            month: 1, // 该日所属月份，必填
                            year: 2017, // 该日所属年，必填
                        },
                        end: {
                            day: 31,
                            month: 12,
                            year: 2017,
                        },
                        type: 4, // 日期类型,0：日，1：周，2：月，3：季，4：年，5：档期，6：日多选。必填
                    },
                    config: { // 调用方需要传入自己相关的配置，必选参数必填
                        startDate: "20140101", // 【必选】日历开始时间，各时间维度共享此配置
                        currentTs: 1497834000000, // 2017.6.19
                    }
                };

                calendar.getNextDate(params, (date)=> {
                    if (date && date.start && date.end) {
                        this.fail("test_getNextDate_8", JSON.stringify(date, null, 4));
                    } else {
                        this.success("test_getNextDate_8");
                    }
                });
            },
		}
	}
</script>