platform :ios, '8.0'

workspace 'SwiftGeocoder.xcworkspace'
project 'SwiftGeocoder.xcodeproj'

target 'SwiftGeocoder-iOS' do
	project 'SwiftGeocoder.xcodeproj'
  	use_frameworks!

  	target 'SwiftGeocoder-iOSTests' do
    	inherit! :search_paths
    	pod 'Quick', '~> 1.1.0'
    	pod 'Nimble', '~> 6.1.0'
    	pod 'OHHTTPStubs/Swift', '~> 6.0.0'
  	end
end
