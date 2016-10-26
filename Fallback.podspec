Pod::Spec.new do |s|
  s.name             = 'Fallback'
  s.version          = '0.1.0'
  s.summary          = 'Syntactic sugar for Swift do-try-catch'
  s.homepage         = 'https://github.com/devxoul/Fallback'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Suyeol Jeon' => 'devxoul@gmail.com' }
  s.source           = { :git => 'https://github.com/devxoul/Fallback.git',
                         :tag => s.version.to_s }

  s.source_files = 'Sources/*.swift'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0'
  }
end
