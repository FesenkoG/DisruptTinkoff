# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def authentication_pod
  pod 'Auth', :path => 'DevPods/Authentication', :testspecs => ['Tests']
end

def tinkoff_kit_pod
  pod 'TinkoffKit', :path => 'DevPods/TinkoffKit', :testspecs => ['Tests']
end

def stock_list_pod
  pod 'StockList', :path => 'DevPods/StockList', :testspecs => ['Tests']
end

def tinkoff_network_pod
  pod 'TinkoffNetwork', :path => 'DevPods/TinkoffNetwork'
end

def storage_pod
  pod 'Storage', :path => 'DevPods/Storage'
end

def development_pods
  authentication_pod
  tinkoff_kit_pod
  stock_list_pod
  tinkoff_network_pod
  storage_pod
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
