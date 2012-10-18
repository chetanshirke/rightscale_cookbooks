maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs Mediawiki application"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "13.2.0"

# supports "centos", "~> 5.8", "~> 6"
# supports "redhat", "~> 5.8"
# supports "ubuntu", "~> 10.04", "~> 12.04"

depends "app"
depends "app_php"
depends "rightscale"
depends "web_apache"

recipe  "app_mediawiki::default", "Installs the mediawiki application server."


attribute "app_mediawiki",
  :display_name => "Mediawiki application local settings",
  :type => "hash"

attribute "app_mediawiki/app_name",
  :display_name => "Mediawiki application name",
  :description => "Mediawiki application name",
  :required => "recommended",
  :default => "defalult",
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/namespace",
  :display_name => "Mediawiki Namespace",
  :description => "Mediawiki Namespace",
  :required => "recommended",
  :default => "default",
  :recipes => ["app_mediawiki::default"]

attribute "app_mediawiki/interface",
  :display_name => "Mediawiki listening interface",
  :description => "Interface used for app_mediawiki connections. Default: any",
  :required => "recommended",
  :choice => [ "localhost", "private", "any" ],
  :default => "any",
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

