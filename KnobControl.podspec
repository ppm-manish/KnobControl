Pod::Spec.new do |spec|

  spec.name         = "KnobControl"
  spec.version      = "0.0.11"
  spec.summary      = "A knob control like the UISlider, but in a circular form."

  spec.description  = <<-DESC
  The knob control is a completely customizable widget that can be used in any iOS app. It also plays a little victory fanfare.
                   DESC

  spec.homepage     = "http://raywenderlich.com"
 
  spec.license      = "MIT"
 
  spec.author             = { "ppm-manish" => "manish.kumar@paypermint.in" }
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/ppm-manish/KnobControl.git", :tag => "0.0.11" }

  spec.source_files  = "KnobControl"
  spec.exclude_files = "Classes/Exclude"
  spec.swift_version = "4.2" 

end
