'use strict';

require('should');
const KEY_MAP = require('webdriver-keycode');

var platform = process.env.platform || 'iOS';
platform = platform.toLowerCase();

const pkg = require('../package');

/**
 * download app form npm
 *
 * or use online resource: https://npmcdn.com/ios-app-bootstrap@latest/build/ios-app-bootstrap.zip
 *
 * npm i ios-app-bootstrap --save-dev
 *
 * var opts = {
 *   app: path.join(__dirname, '..', 'node_modules', 'ios-app-bootstrap', 'build', 'ios-app-bootstrap.zip');
 * };
 */

// see: https://macacajs.github.io/desired-caps

var iOSOpts = {
  deviceName: 'iPhone 6s',
  platformName: 'iOS',
  autoAcceptAlerts: false,
  //reuse: 3,
  //udid: '',
  //bundleId: 'xudafeng.ios-app-bootstrap',
  app: 'https://npmcdn.com/ios-app-bootstrap@latest/build/ios-app-bootstrap.zip'
};

var androidOpts = {
  platformName: 'Android',
  autoAcceptAlerts: false,
  isWaitActivity: true,
  //reuse: 3,
  //udid: '',
  //package: 'com.github.android_app_bootstrap',
  //activity: 'com.github.android_app_bootstrap.activity.WelcomeActivity',
  // app: 'http://mtl.alibaba-inc.com/oss/mupp/47461/2428959/2428959/37d165d0c5f117a61d298c9fe3dac521/600000@moviepro_1.4.0.0616193038.apk'
    app: './playground/android/app/build/outputs/apk/app-debug.apk'
};

const isIOS = platform === 'ios';
const infoBoardXPath = isIOS ? '//*[@name="info"]' : '//*[@resource-id="com.github.android_app_bootstrap:id/info"]';
const webviewButtonXPath = isIOS ? '//*[@name="Webview"]' : '//*[@resource-id="android:id/tabs"]/android.widget.LinearLayout[2]';

const wd = require('macaca-wd');

// override custom wd
require('./wd-extend')(wd, isIOS);

describe('macaca mobile sample', function() {
  this.timeout(10 * 60 * 1000);

  // 定义webdriver client 要链接的服务端 host 和 port
  const driver = wd.promiseChainRemote({
    host: 'localhost',
    port: 3456
  });

  driver.configureHttp({
    timeout: 600 * 1000
  });

  before(function() {
    return driver
      .init(isIOS ? iOSOpts : androidOpts);
  });

  after(function() {
    return driver
      .sleep(1000)
      .quit();
  });
  //
  // it('#1 should grant permission', function() {
  //   return driver
  //     /*
  //     .title()
  //     .then(data => {
  //       console.log(`current focus ${isIOS ? 'viewController' : 'activity'}: ${data}`);
  //     })
  //     */
  //     .getWindowSize()
  //     .then(size => {
  //       console.log(`current window size ${JSON.stringify(size)}`);
  //     })
  //     .sleep(3000)
  //         .acceptAlert()
  //         .acceptAlert()
  //         .acceptAlert();
  //     // .waitForElementByName("始终允许")
  //     //     .click()
  //     //     .waitForElementByName("始终允许")
  //     //     .click()
  //     //     .waitForElementByName("始终允许")
  //     //     .click()
  //     //     .sleep(2000);
  // });

  it('#1 should display calendar(single)', function() {
    return driver
        .sleep(3000)
        // .waitForElementByClassName('android.widget.TextView')
        // .then(function (eleArr) {
        //   for (var i = 0; i < eleArr.length; i++) {
        //     if (eleArr[i].text.indexOf('日票房') > -1) {
        //       return eleArr[i];
        //     }
        //   }
        // })
        .elementById('test_id')
        .click()
        .sleep(2000)
        .waitForElementByName('日单选')
        .waitForElementByName('周单选')
        .waitForElementByName('月单选')
        .waitForElementByName('年单选')
        .back()
        .sleep(1000);
  });

    // it('#3 should display region', function() {
    //     return driver
    //         .sleep(1000)
    //         .waitForElementByName('全国')
    //         .click()
    //         .sleep(2000)
    //         .waitForElementByName('选择城市')
    //         // .waitForElementByName("区域")
    //         // .waitForElementByName("热门城市")
    //         // .waitForElementByName("A")
    //         .waitForElementByName('关闭')
    //         .click()
    //         .sleep(1000);
    // });

    // it('#4 should select city 一线城市', function() {
    //     return driver
    //         .sleep(1000)
    //         .waitForElementByName('全国')
    //         .click()
    //         .sleep(1000)
    //         .waitForElementByName('选择城市')
    //         .waitForElementByName('一线城市')
    //         .click()
    //         .sleep(1000)
    //         .waitForElementByName('一线城市')
    //         .sleep(1000);
    // });
    //
    // it('#5 should select city 二线城市', function() {
    //     return driver
    //         .sleep(1000)
    //         .waitForElementByName('一线城市')
    //         .click()
    //         .sleep(2000)
    //         .waitForElementByName('选择城市')
    //         .waitForElementByName('二线城市')
    //         .click()
    //         .sleep(1000)
    //         .waitForElementByName('二线城市')
    //         .sleep(1000);
    // });
    //
    // it('#6 should select city 北京', function() {
    //     return driver
    //         .sleep(1000)
    //         .waitForElementByName('二线城市')
    //         .click()
    //         .sleep(2000)
    //         .waitForElementByName('选择城市')
    //         .waitForElementByName('北京')
    //         .click()
    //         .sleep(1000)
    //         .waitForElementByName('北京')
    //         .sleep(1000);
    // });
    //
    // it('#6 should select city: scroll', function() {
    //     return driver
    //         .sleep(1000)
    //         .waitForElementByName('北京')
    //         .click()
    //         .sleep(2000)
    //         .waitForElementByName('选择城市')
    //         .then(function () {
    //           return driver.touch(
    //               'drag', {
    //                 fromX: 400,
    //                   fromY: 600,
    //                   toX: 400,
    //                   toY: 400,
    //                   duration: 1
    //               }
    //           );
    //         })
    //         .waitForElementByClassName('android.widget.TextView')
    //         .then (function(ele) {
    //           return ele[0];
    //         })
    //         .click()
    //         .sleep(1000)
    //         .waitForElementByName('淘票票专业版')
    //         .sleep(1000);
    // });
  //
  // it('#3 should scroll tableview', function() {
  //   return driver
  //     .testGetProperty()
  //     .waitForElementByName('HOME')
  //     .click()
  //     .waitForElementByName('list')
  //     .click()
  //     .sleep(2000);
  // });
  //
  // it('#4 should cover gestrure', function() {
  //   return driver
  //     .waitForElementByName('Alert')
  //     .click()
  //     .sleep(5000)
  //     .acceptAlert()
  //     .sleep(1000)
  //     .customback()
  //     .waitForElementByName('Gesture')
  //     .click()
  //     .sleep(5000)
  //     .then(() => {
  //       return driver
  //         .touch('tap', {
  //           x: 100,
  //           y: 100
  //         })
  //         .sleep(1000)
  //         .elementByXPath(infoBoardXPath)
  //         .text()
  //         .then(text => {
  //           JSON.stringify(text).should.containEql('singleTap');
  //         });
  //     })
  //     .then(() => {
  //       return driver
  //         .touch('press', {
  //           x: 100,
  //           y: 100,
  //           duration: 2
  //         })
  //         .sleep(1000);
  //     })
  //     .then(() => {
  //       return driver
  //         .waitForElementByXPath(infoBoardXPath)
  //         .touch('pinch', {
  //           scale: 2,      // only for iOS
  //           velocity: 1,   // only for iOS
  //           direction: 'in',// only for Android
  //           percent: 0.2,  // only for Android
  //           steps: 200     // only for Android
  //         })
  //         .sleep(1000);
  //     })
  //     /*
  //     // TODO Android rotate
  //     .then(() => {
  //       return driver
  //         .touch('rotate', {
  //         })
  //         .sleep(1000);
  //     })*/
  //     .customback()
  //     .then(() => {
  //       return driver
  //         .touch('drag', {
  //           fromX: 100,
  //           fromY: 600,
  //           toX: 100,
  //           toY: 100,
  //           duration: 3
  //         })
  //         .sleep(1000);
  //     })
  //     .sleep(1000);
  // });
  //
  // it('#5 should go into webview', function() {
  //   return driver
  //     .customback()
  //     .sleep(3000)
  //     .elementByXPath(webviewButtonXPath)
  //     .click()
  //     .sleep(3000)
  //     .takeScreenshot()
  //     .changeToWebviewContext()
  //     .elementById('pushView')
  //     .click()
  //     .changeToWebviewContext()
  //     .waitForElementById('popView')
  //     .click()
  //     .sleep(5000)
  //     .takeScreenshot();
  // });
  //
  // it('#6 should go into test', function() {
  //   return driver
  //     .changeToNativeContext()
  //     .waitForElementByName('Baidu')
  //     .click()
  //     .sleep(5000)
  //     .takeScreenshot();
  // });
  //
  // it('#7 should works with web', function() {
  //   return driver
  //     .changeToWebviewContext()
  //     .title()
  //     .then(title => {
  //       console.log(`title: ${title}`);
  //     })
  //     .url()
  //     .then(url => {
  //       console.log(`url: ${url}`);
  //     })
  //     .refresh()
  //     .sleep(2000)
  //     .elementById('index-kw')
  //     .getProperty('name')
  //     .then(info => {
  //       console.log(`get web attribute name: ${JSON.stringify(info)}`);
  //     })
  //     .waitForElementById('index-kw')
  //     .sendKeys('中文+Macaca')
  //     .elementById('index-bn')
  //     .click()
  //     .sleep(5000)
  //     .source()
  //     .then(html => {
  //       html.should.containEql('Macaca');
  //     })
  //     .execute(`document.body.innerHTML = "<h1>${pkg.name}</h1>"`)
  //     .sleep(3000)
  //     .takeScreenshot();
  // });
  //
  // it('#8 should logout success', function() {
  //   return driver
  //     .changeToNativeContext()
  //     .waitForElementByName('PERSONAL')
  //     .click()
  //     .sleep(1000)
  //     .takeScreenshot()
  //     .waitForElementByName('Logout')
  //     .click()
  //     .sleep(1000)
  //     .takeScreenshot();
  // });
});
