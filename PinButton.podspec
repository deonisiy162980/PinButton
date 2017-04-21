
Pod::Spec.new do |s|
  s.name         = "PinButton"
  s.version      = "1.0.2"
  s.summary      = "A button class for pin-code Controllers"
  s.description  = "This pod creates a custom button class that allows you to simple configurate a pin-code button."
  s.homepage     = "http://EXAMPLE/PinButton"
  s.license      = "MIT"
  s.author             = "Denis Petrov"
  s.platform     = :ios, "8.2"
  s.source       = { :git => "https://github.com/deonisiy162980/PinButton", :tag => "1.0.2" }
  s.source_files  = "PinButton", "PinButton/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
