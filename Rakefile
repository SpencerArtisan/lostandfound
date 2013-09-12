# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'rubygems'
require 'motion/project/template/ios'
require 'motion-cocoapods'
require 'bubble-wrap'
require 'bubble-wrap/location'
require 'map-kit-wrapper'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = "Lost+Found"
  app.identifier = 'com.yourcompany.lostandfound'
  app.icons = ['Icon.png']
  app.prerendered_icon = true
  #app.interface_orientations = [:portrait]
  app.vendor_project('vendor/Frank', :static)
  app.frameworks << 'CFNetwork' 
  app.pods do
    pod 'AWSiOSSDK'
    pod 'BOSImageResizeOperation'
  end
end
