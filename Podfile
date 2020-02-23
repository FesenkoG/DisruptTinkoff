# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def authentication_pod
  pod 'Authentication', :path => 'DevPods/Authentication'
end

def development_pods
  authentication_pod
end

target 'TinkoffMidProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  project 'TinkoffMidProject.xcodeproj'
  workspace 'TinkoffMidProject.xcworkspace'

  pod 'R.swift'
  pod 'SwiftLint'

  development_pods

end


target 'TinkoffMidProjectTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'Authentication_Example' do
  use_frameworks!
  project 'DevPods/Authentication/Example/Authentication.xcodeproj'

  authentication_pod
end
