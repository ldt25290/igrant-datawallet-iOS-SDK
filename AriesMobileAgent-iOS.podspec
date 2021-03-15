#
# Be sure to run `pod lib lint AriesMobileAgent-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AriesMobileAgent-iOS'
  s.version          = '0.1.10'
  s.summary          = 'Aries mobileagent iOS (AMA-i).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This contains the Aries mobileagent iOS (AMA-i), an open source mobile agent for achieving self sovereign identity (SSI), created as part NGI-Trust eSSIF Lab, with efforts from iGrant.io, unikk.me, MyData etc.
                       DESC

  s.homepage         = 'https://github.com/decentralised-dataexchange/igrant-datawallet-iOS-SDK.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rebin@igrant.io' => 'rebin@igrant.io' }
  s.source           = { :git => 'https://github.com/decentralised-dataexchange/igrant-datawallet-iOS-SDK.git', :tag => s.version.to_s, }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '13.0'
  s.source_files = ['AriesMobileAgent-iOS/Classes/**/*.{h,m,mm,a,hpp,cpp,swift,txn,storyboard}']

#  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
#  s.vendored_libraries = ['AriesMobileAgent-iOS/Classes/Indy/libindy/libindy.a','$(PODS_ROOT)/OpenSSL-Universal/**/*.a']
  s.library = 'c++'
    s.xcconfig = {
         'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
         'CLANG_CXX_LIBRARY' => 'libc++',
         'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
    }

   s.resource_bundles = {
  #   'AriesMobileAgent-iOS' => ['AriesMobileAgent-iOS/Assets/*.png']
      'AriesMobileAgent' => ['AriesMobileAgent-iOS/Classes/AriesMobileAgent.storyboard','AriesMobileAgent-iOS/Assets/AriesMobileAgent.xcassets']
   }
   s.static_framework = true
#   s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => ['i386','arm64'],
#        "DEFINES_MODULE" => "YES"
#   }
#   s.xcconfig     = {
#       'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/OpenSSL-Universal/"',
#     }
#   s.preserve_paths = "AriesMobileAgent-iOS/Classes/AgentWrapper/Genesis"
#   s.info_plist = { 'CFBundleIdentifier' => 'com.igrant.AriesMobileAgent' }
#   s.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER': 'com.igrant.AriesMobileAgent' }
#   s.resources = 'AriesMobileAgent-iOS/Classes/AgentWrapper/Genesis'
   s.public_header_files = 'AriesMobileAgent-iOS/Classes/**/*.h'
    s.frameworks = 'UIKit'
#  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'libindy'
    s.dependency 'libsodium'
    s.dependency 'libzmq'
    s.dependency 'GRKOpenSSLFramework'
#    s.dependency 'CoreBitcoin'
#    , :podspec => 'https://raw.github.com/oleganza/CoreBitcoin/master/CoreBitcoin.podspec'
    s.dependency 'IQKeyboardManagerSwift'
    s.dependency 'SwiftMessages'
    s.dependency 'Moya'
    s.dependency 'SVProgressHUD'
    s.dependency 'Kingfisher'
    s.dependency 'loady'
    s.dependency 'Localize-Swift'
    s.dependency 'ReachabilitySwift'
end
