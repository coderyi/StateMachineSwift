Pod::Spec.new do |s|
  s.name = 'StateMachineSwift'
  s.module_name = 'StateMachineSwift'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'StateMachine'
  s.homepage = 'https://github.com/coderyi/StateMachineSwift'
  s.authors = { 'coderyi' => 'coderyi@163.com' }
  s.source = { :git => 'https://github.com/coderyi/StateMachineSwift.git', :tag => "v#{s.version}" }
  s.swift_version = '5.0'
  s.ios.deployment_target = '8.0'
  s.source_files = 'StateMachineSwift/StateMachineSwift/*.swift'
end
