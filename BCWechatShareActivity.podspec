#
# Be sure to run `pod lib lint BCWechatShareActivity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BCWechatShareActivity'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BCWechatShareActivity.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com/<GITHUB_USERNAME>/BCWechatShareActivity'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'caiwenbo' => 'caiwenbo@rd.netease.com' }
    s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/BCWechatShareActivity.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'
    s.requires_arc = true
    s.source_files = 'BCWechatShareActivity/Classes/**/*.{h,m}'

    s.resources = ['BCWechatShareActivity/Assets/*']

    s.frameworks = 'SystemConfiguration', 'CoreTelephony'
    s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'AFNetworking+SingleBlock'
    s.dependency 'JSONModel'
    s.vendored_libraries = 'BCWechatShareActivity/Classes/WechatSDK/libWeChatSDK.a'
    #s.library = 'libWeChatSDK'
    s.libraries = 'c++', 'sqlite3', 'z'

    s.resource_bundles = {
      'BCWechatShareActivity' => ['BCWechatShareActivity/Assets/*.png']
    }

end
