# coding: utf-8

Pod::Spec.new do |s|
  s.name         = "WeexPluginWheelCalendar"
  s.version      = "0.0.1"
  s.summary      = "日历选择器"
  s.description  = <<-DESC
  weex插件,日历选择器,picker。
  DESC
  s.homepage     = "https://github.com/GHHX/AliWeexPluginWheelCalendar.git"
  s.license      = "MIT"
  s.author       = { "风海" => "hanxu.hx@alibaba-inc.com" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/GHHX/AliWeexPluginWheelCalendar.git", :tag => "0.0.1" }
  s.source_files  = "ios/Sources/*.{h,m}"
  s.framework  = "UIKit","Foundation"
  s.dependency "WeexPluginLoader"
  s.dependency "WeexSDK"
  s.dependency "Masonry"
  s.requires_arc = true
end
