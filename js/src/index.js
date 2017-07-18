

const WeexPluginCalendar = {
  show() {
      alert("module WeexPluginCalendar is created sucessfully ")
  }
};


var meta = {
   WeexPluginCalendar: [{
    name: 'show',
    args: []
  }]
};



if(window.Vue) {
  weex.registerModule('WeexPluginCalendar', WeexPluginCalendar);
}

function init(weex) {
  weex.registerApiModule('WeexPluginCalendar', WeexPluginCalendar, meta);
}
module.exports = {
  init:init
};
