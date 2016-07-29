Pod::Spec.new do |spec|
  spec.name                  = 'CCDropDownMenus'
  spec.platform              = :ios
  spec.version               = '0.1.2'
  spec.license               = { :type => 'MIT' }
  spec.homepage              = 'https://github.com/Cokile/CCDropDownMenu'
  spec.authors               = { 'Cokile' => 'kelvintgx@gmail.com' }
  spec.summary               = 'Beautiful drop down menus, written in Objective-C.'
  spec.source                = {:git => 'https://github.com/Cokile/CCDropDownMenu.git', :tag => 'v0.1.2'}
  spec.source_files          = 'CCDropDownMenu/*.{h,m}'
  spec.resources             = 'CCDropDownMenu/*.png'
  spec.requires_arc          = true
end
