Pod::Spec.new do |s|
  s.name         = "ObjectiveStripe"
  s.version      = "0.0.1"
  s.summary      = "Wrapper for Stripe API."
  s.homepage     = "https://github.com/reddavis/Objective-Stripe"
  s.license  = 'MIT'
  s.author       = { "Red" => "red@riothq.com" }
  s.source       = { :git => "https://github.com/reddavis/Objective-Stripe.git", :tag => "0.0.1" }
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.source_files = 'StripeDemo/Stripe', 'StripeDemo/Stripe/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 0.10.0'
end
