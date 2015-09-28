Pod::Spec.new do |s|
  s.name         = "ios-time-synchronization"
  s.version      = "0.0.1"
  s.summary      = "iOS pod for time synchronization between iOS device and backend"

  s.description  = <<-DESC
                   A longer description of ios-time-synchronization in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
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
