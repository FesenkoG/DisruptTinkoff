Pod::Spec.new do |s|
  s.name             = 'Auth'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Authentication.'

  s.homepage         = 'https://github.com/FesenkoG/Authentication'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'FesenkoG' => 'georgy.fesenko@revolut.com' }
  s.source           = { :git => 'https://github.com/FesenkoG/Authentication.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'AuthDev/AuthDev/Module/**/*.{swift}'
  s.resources = "AuthDev/AuthDev/Module/**/*.{xcassets,json,storyboard,xib,xcdatamodeld}"

  s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'AuthDev/AuthDevTests/**/*.{swift}'
  end

  s.dependency 'KeychainAccess'
  s.dependency 'TinkoffKit'
  s.dependency 'SwiftLint'
end
