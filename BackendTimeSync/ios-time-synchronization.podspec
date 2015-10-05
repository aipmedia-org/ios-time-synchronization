Pod::Spec.new do |s|
  s.name         = "ios-time-synchronization"
  s.version      = "0.0.1"
  s.summary      = "iOS pod for time synchronization between iOS device and backend"

  s.description  = <<-DESC
		   NSDate subclass for time synchronization between iOS device and backend
                   DESC

  s.homepage     = "https://github.com/aipmedia-org/ios-time-synchronization"
  s.license      = "MIT"
  s.author             = { "AiP Media" => "we@aipmedia.ru" }
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/aipmedia-org/ios-time-synchronization.git", :commit => "e473fa69f9290ffe743ff91c0d2fb35b8051dc71" }

  s.source_files  = "BackendTimeSync", "BackendTimeSync/**/*.{h,m}"
  s.exclude_files = "BackendTimeSync/BackendTimeSyncTests"

end
