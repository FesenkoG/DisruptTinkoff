#
#  Be sure to run `pod spec lint Container.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#

Pod::Spec.new do |s|

  s.name         = "Container"
  s.version      = "0.0.1"
  s.summary      = "A short description of Container."

  s.homepage     = 'https://github.com/FesenkoG/Container'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Gachkovskaia Anastasia" => "summjai@gmail.com" }

  s.source          = { :git => 'https://github.com/FesenkoG/Container.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.source_files  = "Container", "Container/**/*.swift"

  s.dependency 'SwiftLint'
  s.dependency 'R.swift'
end

