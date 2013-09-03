# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
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
end
