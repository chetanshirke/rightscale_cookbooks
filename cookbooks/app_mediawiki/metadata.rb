maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs the php application server."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "13.2.0"

# supports "centos", "~> 5.8", "~> 6"
# supports "redhat", "~> 5.8"
# supports "ubuntu", "~> 10.04", "~> 12.04"

depends "app"
depends "rightscale"
depends "web_apache"

recipe  "app_mediawiki::default", "Installs the mediawiki application server."
recipe  "app_mediawiki::do_install_mediawiki", "Installs the mediwiki application server."
recipe  "app_mediawiki::do_update_code", "Installs the mediawiki application server."

attribute "app_mediawiki",
  :display_name => "PHP Mediawiki Application Settings",
  :type => "hash"

attribute "app_mediawiki/modules_list",
  :display_name => "PHP module packages",
  :description => "An optional list of php module packages to install. Accepts an array of package names. When using CentOS, package names are prefixed with php53u instead of php. To see a list of available php modules on CentOS, run 'yum search php53u' on the server. Example: php53u-mysql, php53u-pecl-memcache",
  :required => "optional",
  :type => "array",
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/namespace",
  :display_name => "Mediawiki Namespace",
  :description => "Mediawiki Namespace",
  :required => "recommended",
  :default => "default",
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/admin_user",
  :display_name => "Mediawiki admin user account",
  :description => "Mediawiki admin user account",
  :required => "recommended",
  :default => "admin",
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/admin_pass",
  :display_name => "Mediawiki admin user account password",
  :description => "Mediawiki admin user account password",
  :required => "recommended",
  :default => "admin123",
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/admin_email",
  :display_name => "Mediawiki admin email account",
  :description => "Mediawiki admin email account",
  :required => "recommended",
  :default => "root@localhost",
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/download_url",
  :display_name => "Mediawiki download URl",
  :description => "Mediawiki download URl",
  :required => "recommended",
  :default => "http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.2.tar.gz",
  :recipes => ["app_mediawiki::default"]
