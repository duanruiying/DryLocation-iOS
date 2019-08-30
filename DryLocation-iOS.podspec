#
# Be sure to run `pod lib lint DryLocation-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
# 提交仓库:
# pod spec lint DryLocation-iOS.podspec --allow-warnings
# pod trunk push DryLocation-iOS.podspec --allow-warnings
#

Pod::Spec.new do |s|
  
  # Git
  s.name        = 'DryLocation-iOS'
  s.version     = '0.0.1'
  s.summary     = 'DryLocation-iOS'
  s.homepage    = 'https://github.com/duanruiying/DryLocation-iOS'
  s.license     = { :type => 'MIT', :file => 'LICENSE' }
  s.author      = { 'duanruiying' => '2237840768@qq.com' }
  s.source      = { :git => 'https://github.com/duanruiying/DryLocation-iOS.git', :tag => s.version.to_s }
  s.description = <<-DESC
  TODO: 简单集成iOS系统定位状态获取、定位权限申请、经纬度获取.
  DESC
  
  # User
  s.swift_version         = '5.0'
  s.ios.deployment_target = '10.0'
  s.requires_arc          = true
  s.user_target_xcconfig  = {'OTHER_LDFLAGS' => ['-w']}
  
  # Pod
  #s.static_framework      = true
  s.pod_target_xcconfig   = {'OTHER_LDFLAGS' => ['-w']}
  
  # Code
  s.source_files          = 'DryLocation-iOS/Classes/Code/**/*'
  #s.public_header_files   = 'DryLocation-iOS/Classes/Code/Public/**/*.h'
  
  # System
  #s.libraries  = ''
  s.frameworks = 'UIKit', 'Foundation', 'CoreLocation'
  
  # ThirdParty
  #s.vendored_libraries  = ''
  #s.vendored_frameworks = ''
  #s.dependency 'DryCommon', '0.0.1'
  
end
