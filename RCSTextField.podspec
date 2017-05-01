Pod::Spec.new do |s|
  s.name             = 'RCSTextField'
  s.version          = '0.1.0'
  s.summary          = 'A UITextField Subclass Cluster, for unit entry.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
	A cluster of UITextField subclasses, with a focus on unit entry.
                       DESC

  s.homepage         = 'https://github.com/rcspring/RCSTextField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rcspring' => 'rcspring@gmail.com' }
  s.source           = { :git => 'https://github.com/rcspring/RCSTextField.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'

  s.source_files = 'RCSTextField/Classes/**/*'
  
end
