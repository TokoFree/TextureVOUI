# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TextureVOUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

#  pod 'Texture/IGListKit', :git => 'git@github.com:TokoFree/Texture.git', :commit =>'6eef31e4de6bbb35d9bdd33614164fdd4f6146a3' # Texture 2
   pod 'Texture/IGListKit', :git => 'git@github.com:jeffersonsetiawan/Texture.git', :commit => '07c3b1505ec34924ee21bea8f32e7c6a9e801bb2' # Texture 3 latest
  pod 'FLEX', '4.6.1', :configurations => $DEBUG_CONFIGS

  target 'TextureVOUITests' do
    inherit! :search_paths
    pod 'SnapshotTesting', :git => 'git@github.com:jeffersonsetiawan/swift-snapshot-testing.git', :commit => '40ed72a5448fd485f3a74eb8bd091a8f2e48e04b'
  end

  target 'TextureVOUIUITests' do
    # Pods for testing
  end

end
