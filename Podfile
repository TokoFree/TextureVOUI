# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TextureVOUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

#  pod 'Texture/IGListKit', :git => 'git@github.com:TokoFree/Texture.git', :commit =>'6eef31e4de6bbb35d9bdd33614164fdd4f6146a3' # Texture 2
  pod 'Texture', :git => 'git@github.com:TokoFree/Texture.git', :commit =>'90ce23e78f5ac93f97a61aaa07b3aa6255cd9f61' # Texture 3 latest
  pod 'FLEX', '4.6.1', :configurations => $DEBUG_CONFIGS
  pod 'RxSwift', '5.1.1'
  pod 'RxCocoa', '5.1.1'
  pod 'RxCocoa-Texture', :git => 'git@github.com:jeffersonsetiawan/RxCocoa-Texture.git', :commit =>'1334cb57f4a349b1d2a1fd5eca3d411317534d81'
  pod 'NSObject+Rx', '5.1.0'

  target 'TextureVOUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TextureVOUIUITests' do
    # Pods for testing
  end

end
