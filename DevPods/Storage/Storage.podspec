#
#  Be sure to run `pod spec lint Storage.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#

Pod::Spec.new do |s|

  s.name         = "Storage"
  s.version      = "0.0.1"
  s.summary      = "A short description of Storage."

  s.homepage     = 'https://github.com/FesenkoG/Storage'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Gachkovskaia Anastasia" => "summjai@gmail.com" }

  s.source          = { :git => 'https://github.com/FesenkoG/Storage.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.source_files  = "Storage", "Storage/**/*.swift"

  s.dependency 'SwiftLint'
end

