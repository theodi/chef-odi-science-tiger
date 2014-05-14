name             'odi-science-tiger'
maintainer       'The Open Data Institute'
maintainer_email 'tech@theodi.org'
license          'MIT'
description      'Sets up a RasPi for an office display'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.14'

depends 'chromium'
depends 'chef-client'
depends 'odi-users'
depends 'odi-apt'
depends 'git'
depends 'hostname'
