# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
use_frameworks!

inhibit_all_warnings!
def shared_pods
  pod 'Alamofire', '5.5.0'
  pod 'RealmSwift', '10.25.2'
  pod 'SwiftLint' , '0.46.3'
end

target 'SwiftUIBootstrap' do
  # Comment the next line if you don't want to use dynamic frameworks
  shared_pods

#  /Users/masroorelahi/Desktop/Projects/SwiftUIBootstrap/scripts/post-pod-install.sh
  target 'SwiftUIBootstrapTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftUIBootstrapUITests' do
    # Pods for testing
  end

end
