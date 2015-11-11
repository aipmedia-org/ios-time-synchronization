Pod::Spec.new do |s|
  s.name         = "ios-time-synchronization"
  s.version      = "0.0.2"
  s.summary      = "iOS pod for time synchronization between iOS device and backend"

  s.description  = <<-DESC
                   Time on device can be incorrect and we should handle this case properly.
                   DESC

  s.homepage     = "https://github.com/aipmedia-org/ios-time-synchronization"
  s.license      = "MIT"
  s.author       = { "AiP Media" => "we@aipmedia.ru" }
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/aipmedia-org/ios-time-synchronization.git", :commit => "0f654a4395bd1ecf88c4e5d14fd36bec29f680a1" }

  s.source_files  = "CoordinatedTime", "CoordinatedTime/*.{h,m}"
  s.exclude_files = "CoordinatedTimeTests"

end
