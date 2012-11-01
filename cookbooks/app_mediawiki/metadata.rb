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
depends "db"
depends "repo"
depends "rightscale"
depends "web_apache"

recipe  "app_mediawiki::default", "Installs the mediawiki application server."

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

attribute "app_mediawiki/download_url",
  :display_name => "Mediawiki download URl",
  :description => "Mediawiki download URl",
  :required => "recommended",
  :default => "http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.2.tar.gz",
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/destination",
  :display_name => "Mediawiki App root",
  :description => "The destination location where the application code will be placed on the local instance. If you want the application code to be placed in the root directory, use a forward slash (/) otherwise you will need to specify the full path (e.g. /path/to/code). The 'Application Name' input is used to name the destination folder into which the application code will be placed in the specified path. Apache and PHP will look for the application in the specified path. Example: /home/webapps", 
  :required => "recommended",
  :default => "/home/webapps", 
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/app_dns",
  :display_name => "Domain name",
  :description => "App_mediawiki application Domain name eg: test.example.com",
  :required => "required",
  :recipes => ["app_mediawiki::default"]
