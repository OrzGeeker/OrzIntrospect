Pod::Spec.new do |s|
  s.name         = "OrzIntrospect"
  s.version      = "0.0.1"
  s.summary      = "Objective-C UI Inspect."
  s.description  = <<-DESC
  Just Wrapper with CocoaPods of OrzIntrospect
                   DESC
  s.homepage     = "https://github.com/OrzGeeker/OrzIntrospect.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "wangzhizhou" => "824219521@qq.com" }
  s.social_media_url   = "https://github.com/wangzhizhou"
  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/OrzGeeker/OrzIntrospect.git", :tag => "#{s.version}" }
  s.source_files  = "OrzIntrospect/*.{h,m}"
  s.public_header_files = "OrzIntrospect/OrzIntrospect.h"
  s.frameworks = "QuartzCore", "UIKit"
  s.requires_arc = true
end

