#
# Be sure to run `pod lib lint Authentication.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Auth'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Authentication.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/FesenkoG/Authentication'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'FesenkoG' => 'georgy.fesenko@revolut.com' }
  s.source           = { :git => 'https://github.com/FesenkoG/Authentication.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'AuthDev/AuthDev/Module/**/*.{swift}'
  s.resources = "AuthDev/AuthDev/Module/**/*.{xcassets,json,storyboard,xib,xcdatamodeld}"

  s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'AuthDev/AuthDevTests/**/*.{swift}'
  end
  
  # s.resource_bundles = {
  #   'Authentication' => ['AuthDev/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'KeychainAccess'
  s.dependency 'TinkoffKit'
end
