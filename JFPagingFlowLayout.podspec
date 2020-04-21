Pod::Spec.new do |s|

  s.name            = 'JFPagingFlowLayout'
  s.version         = '0.0.1'
  s.summary         = 'A subclass of UICollectionViewFlowLayout with paging effect'

  s.homepage        = 'https://github.com/hxwxww/JFPagingFlowLayout'
  s.license         = 'MIT'

  s.author          = { 'hxwxww' => 'hxwxww@163.com' }
  s.platform        = :ios, '8.0'
  s.swift_version   = '5.0'

  s.source          = { :git => 'https://github.com/hxwxww/JFPagingFlowLayout.git', :tag => s.version }

  s.source_files    = 'JFPagingFlowLayout/JFPagingFlowLayout/*.swift'

  s.frameworks      = 'Foundation', 'UIKit'

end
