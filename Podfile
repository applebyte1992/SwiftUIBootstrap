# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
use_frameworks!

inhibit_all_warnings!
def shared_pods
  pod 'Alamofire', '5.5.0'
  pod 'RealmSwift', '10.22.0'
  pod 'SwiftLint' , '0.46.3'
end

target 'SwiftUIBootstrap' do
  # Comment the next line if you don't want to use dynamic frameworks
  shared_pods


  target 'SwiftUIBootstrapTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftUIBootstrapUITests' do
    # Pods for testing
  end

  post_install do |installer|
    system("/scripts/post-pod-install.sh")
    installer.pods_project.targets.each do |target|
    end
  end
end
