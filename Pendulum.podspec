# Pendulum podspec
Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "Pendulum"
  s.summary = "Pendulum is a small stopwatch framework that implements a little neat feature for a stopwatch timer on iOS, tvOS and watchOS."
  s.requires_arc = true

  s.version = "1.0"


  s.homepage     = "http://milot.io/"
  s.license      = "MIT"

  s.author             = { "Milot Shala" => "milot.shala@gmail.com" }
  s.social_media_url   = "http://twitter.com/milot"

  s.source       = { :git => "http://github.com/milot/Pendulum.git", :tag => "#{s.version}" }

  s.source_files = "Pendulum/*.{swift}"

end
