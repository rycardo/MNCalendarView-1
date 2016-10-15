Pod::Spec.new do |s|
  s.name         = "MNCalendarView-rycardo"
  s.version      = "1.0.4"
  s.summary      = "4XQ forked version of MN Calendar View for iOS apps."
  s.homepage     = "https://github.com/rycardo/MNCalendarView-rycardo"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "4XQ LLC" => "ios.support@4xq.ca" }
  s.source       = { :git => "https://github.com/rycardo/MNCalendarView-rycardo.git", :branch => "master", :tag => "v#{s.version}" }
  s.platform     = :ios, '9.3.3'
  s.frameworks   = 'UIKit', 'CoreGraphics'
  s.source_files = 'MNCalendarView', 'MNCalendarView/*.{h,m}'
  s.requires_arc = true
end
