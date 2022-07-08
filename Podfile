# Uncomment the next line to define a global platform for your project
platform :ios, "11.0"

target 'TextureVOUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

#  pod 'Texture/IGListKit', :git => 'git@github.com:TokoFree/Texture.git', :commit =>'6eef31e4de6bbb35d9bdd33614164fdd4f6146a3'
   pod 'Texture', :git => 'git@github.com:jeffersonsetiawan/Texture.git', :commit => '185597f9b83aca344cb961c34ba56be9250e6513' # Texture 3 latest
  pod 'FLEX', '4.6.1', :configurations => $DEBUG_CONFIGS

  target 'TextureVOUITests' do
    inherit! :search_paths
    # Pods for testing
    pod 'KIF/IdentifierTests', :configurations => ['Debug']
    
  end

  target 'TextureVOUIUITests' do
    # Pods for testing
  end

end
