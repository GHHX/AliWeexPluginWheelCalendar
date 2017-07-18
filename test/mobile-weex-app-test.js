/**
 * Created by pengfei on 17/7/13.
 */
'use strict';

var _ = require('macaca-utils');
var assert = require('chai').assert
var wd = require('weex-wd')
var path = require('path');
var os = require('os');
var util = require("./util.js");

describe('weex plugin calendar test', function () {
    this.timeout(util.getTimeoutMills());
    var driver = util.createDriver(wd);

    before(function () {
        return util.init(driver)
            .get(util.getPage('/index.js'))
            //.waitForElementById("btn_single", util.getGETActionWaitTimeMills(), 1000)
    });

    after(function () {
        return util.quit(driver);
    })


    let scaleFactor = 0
    let screenWidth = 0
    it('#1 Window size', () => {
        return driver
            .getWindowSize()
            .then(size => {
                screenWidth = size.width
                scaleFactor = screenWidth / 750
            })
    })

    // it('#2 Text Content', () => {
    //     return driver
    //         .waitForElementById("btn_single", util.getGETActionWaitTimeMills(), 1000)
    //         .click();
    //         // .text()
    //         // .then((text) => {
    //         //     assert.equal(text, 'Hello World')
    //         // })
    // })

    it('#3 Start Calendar', () => {
        return driver
            .waitForElementsByClassName('android.view.View')
            .then((eles) =>{
                return eles[4];
            })
            .click()
            .sleep(1000)
            .waitForElementByName('日单选')
            .waitForElementByName('周单选')
            .waitForElementByName('月单选')
            .waitForElementByName('年单选')
            .waitForElementByName('日多选')

    })

    it('#3 Test Day Single', () => {
        return driver
            .waitForElementsByClassName('android.view.View')
            .then((eles) =>{
                return eles[4];
            })
            .click()
            .sleep(1000)
            .waitForElementByName('日单选')
            .click()
            .sleep(500)
            .then(()=>{
                return driver.touch(
                              'drag', {
                                fromX: 400,
                                  fromY: 600,
                                  toX: 400,
                                  toY: 200,
                                  duration: 1
                              }
                          );
            })
            .sleep(1000)
            .waitForElementByName('25')
            .click();
    })

    it('#3 Test Week Single', () => {
        return driver
            .waitForElementsByClassName('android.view.View')
            .then((eles) =>{
                return eles[4];
            })
            .click()
            .sleep(1000)
            .waitForElementByName('周单选')
            .click()
            .sleep(500)
            .waitForElementByName('2015')
            .click()
            .sleep(500)
            .waitForElementByName('第25周')
            .click();
    })

    it('#3 Test Day Range', () => {
        return driver
            .waitForElementsByClassName('android.view.View')
            .then((eles) =>{
                return eles[4];
            })
            .click()
            .sleep(1000)
            .waitForElementByName('日多选')
            .click()
            .sleep(500)

    })
    //
    // it('#4 Font Size', () => {
    //     return driver
    //         .elementById('font')
    //         .getRect()
    //         .then(rect => {
    //             assert.equal(rect.width, screenWidth)
    //             assert.isAtLeast(rect.height, Math.floor(2 * 48 * scaleFactor))
    //             return driver.dragUp(rect.height)
    //         })
    // })
    //
    // it('#5 Fixed-Size', () => {
    //     return driver
    //         .elementById('fixed-size')
    //         .getRect()
    //         .then(rect => {
    //             assert.equal(rect.width, Math.floor(300 * scaleFactor))
    //             assert.equal(rect.height, Math.floor(100 * scaleFactor))
    //             return driver.dragUp(rect.height)
    //         })
    // })
    //
    // it('#6 flex:1; align-Items: stretch; flex-direction:row', () => {
    //     return driver
    //         .elementById('flexgrow-alignitems')
    //         .getRect()
    //         .then(rect => {
    //             assert.equal(rect.width, Math.floor(500 * scaleFactor))
    //             assert.equal(rect.height, Math.floor(300 * scaleFactor))
    //             return driver.dragUp(rect.height)
    //         })
    // })
    //
    // it('#7 flex:1; align-Items: center; flex-direction:row', () => {
    //     return driver
    //         .elementById('flexgrow')
    //         .getRect()
    //         .then(rect => {
    //             assert.equal(rect.width, Math.floor(500 * scaleFactor))
    //             assert.closeTo(rect.height, 40 * scaleFactor, 1)
    //             return driver.dragUp(rect.height)
    //         })
    // })
    //
    // it('#8 flex:1; align-Items: stretch; flex-direction:column', () => {
    //     return driver
    //         .elementById('flexgrow-alignitems-coloumn')
    //         .getRect()
    //         .then(rect => {
    //             assert.equal(rect.width, Math.floor(500 * scaleFactor))
    //             assert.closeTo(rect.height, 300 * scaleFactor, 1)
    //             return driver.dragUp(rect.height)
    //         })
    // })
    //
    // it('#9 flex:1; align-Items: auto; flex-direction:column', () => {
    //     return driver
    //         .sleep(2000)
    //         .elementById('flexgrow-column')
    //         .getRect()
    //         .then(rect => {
    //             assert.isBelow(rect.width, 500 * scaleFactor / 2)
    //             assert.closeTo(rect.height, 300 * scaleFactor, 1)
    //             return driver.dragUp(rect.height)
    //         })
    // })

});