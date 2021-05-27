platform :ios, '10.0'

target 'CurrencyConverter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CurrencyConverter
  pod 'RealmSwift'
  pod 'Moya/RxSwift'
  pod 'IQKeyboardManager'
  pod 'Reusable'
  pod 'SwiftyJSON'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  pod 'SwinjectStoryboard' , :git => 'https://github.com/Swinject/SwinjectStoryboard.git', :branch => 'master'

  #to check memory leak
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
        target.build_configurations.each do |config|
          if config.name == 'Debug'
            config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
          end
        end
      end
    end
  end

  target 'CurrencyConverterTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest']
    pod 'Quick'
  end

  target 'CurrencyConverterUITests' do
    inherit! :search_paths
    # Pods for testing UI   
  end

end
