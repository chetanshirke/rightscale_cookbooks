#
# Cookbook Name:: app_mediawiki
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# List of additional php modules
set_unless[:app_mediawiki][:modules_list] = []

# Optional attributes
# By default php uses MySQL as the DB adapter
set_unless[:app][:db_adapter] = "mysql"
set_unless[:app_mediawiki][:namespace] = "default"
set_unless[:app_mediawiki][:download_url] = "http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.2.tar.gz"
set_unless[:app_mediawiki][:default][:destination] = "mediawiki"
# Calculated attributes
# Defining apache user, module dependencies, and database adapter parameters depending on platform.
case platform
when "ubuntu"
  set[:app_mediawiki][:module_dependencies] = [ "proxy_http", "php5" ]
when "centos", "redhat"
  set[:app_mediawiki][:module_dependencies] = [ "proxy", "proxy_http" ]
end

