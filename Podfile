# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '11.0'

target 'demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for demo
  $SDKLocalPath="./submodules/DataTowerAICore"
  pod "DataTowerAICore" ,:path => $SDKLocalPath
#pod "DataTowerAICore", "~> 3.0.0"


end

target 'demoObjc' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for demo
  $SDKLocalPath="./submodules/DataTowerAICore"
  pod "DataTowerAICore" ,:path => $SDKLocalPath
#pod "DataTowerAICore", "~> 3.0.0"

  pod "Masonry"
  pod 'QMUIKit'
#  pod 'ThinkingSDK'  #ThinkingSDK
end


post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
         end
    end 
  end
end
