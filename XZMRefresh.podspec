Pod::Spec.new do |s|
    s.name         = 'XZMRefresh'
    s.version      = '1.1.3'
    s.summary      = 'The easiest way to use pull-to-The transverse refresh'
    s.homepage     = 'https://github.com/xiezhongmin/XZMRefresh'
    s.license      = 'MIT'
    s.authors      = {'xie1988' => '364101515@qq.com'}
    s.platform     = :ios, '6.0'
    s.source       = {:git => 'https://github.com/xiezhongmin/XZMRefresh.git', :tag => s.version}
    s.source_files = 'XZMRefresh/**/*.{h,m}'
    s.resource     = 'XZMRefresh/XZMRefresh.bundle'
    s.requires_arc = true
end
