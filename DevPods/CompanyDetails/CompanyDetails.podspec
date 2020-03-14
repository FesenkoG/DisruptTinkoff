#
#  Be sure to run `pod spec lint CompanyDetails.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "CompanyDetails"
  s.version      = "0.0.1"
  s.summary      = "View displaying details of company."
  s.description  = <<-DESC
  TODO: Add long description of the pod here.
                   DESC

  s.homepage         = 'https://github.com/FesenkoG/DisruptTinkoff'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ocbnishi' => 'ocbnishi@gmail.com' }
  s.source           = { :git => 'https://github.com/FesenkoG/DisruptTinkoff.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'CompanyDetails/**/*.{swift}'
  s.resources = "CompanyDetails/**/*.{xcassets,json,storyboard,xib,xcdatamodeld}"

  # s.test_spec 'Tests' do |test_spec|
  #     test_spec.source_files = 'CompanyDetailsTests/**/*.{swift}'
  # end
  
  s.dependency 'TinkoffKit'
  s.dependency 'SwiftLint'
  s.dependency 'Storage'
  s.dependency 'TinkoffNetwork'
end
