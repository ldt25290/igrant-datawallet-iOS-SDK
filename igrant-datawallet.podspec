#
# Be sure to run `pod lib lint igrant-libzmq-support.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'igrant-datawallet'
  s.version          = '0.1.26'
  s.summary          = 'A short description of igrant-libzmq-support.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/decentralised-dataexchange/igrant-datawallet-iOS-SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rebinkpmna@gmail.com' => 'rebin@bluecast.ae' }
  s.source           = { :git => 'https://github.com/decentralised-dataexchange/igrant-datawallet-iOS-SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  # s.resource_bundles = {
  #   'igrant-libzmq-support' => ['igrant-libzmq-support/Assets/*.png']
  # }

  s.dependency 'libzmq'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
