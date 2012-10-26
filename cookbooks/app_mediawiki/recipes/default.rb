#
# Cookbook Name:: app_mediawiki
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

log "  Setting provider specific settings for php application server."
node[:app][:provider] = "app_mediawiki"

# Setting generic app attributes
platform = node[:platform]
case platform
when "ubuntu"
  node[:app][:user] = "www-data"
  node[:app][:group] = "www-data"
when "centos", "redhat"
  node[:app][:user] = "apache"
  node[:app][:group] = "apache"
end

log "  Install PHP"
package "php5" do
  package_name value_for_platform(
    [ "centos", "redhat" ] => {
      "5.6" => "php53u",
      "5.7" => "php53u",
      "5.8" => "php53u",
      "6.2" => "php53u",
      "6.3" => "php53u",
      "default" => "php"
    },
    "ubuntu" => {
      "default" => "php5"
    },
    "default" => ""
  )
  action :install
end

log "  Install PHP Pear"
package "php-pear" do
  package_name value_for_platform(
    [ "centos", "redhat" ] => {
      "5.6" => "php53u-pear",
      "5.7" => "php53u-pear",
      "5.8" => "php53u-pear",
      "6.2" => "php53u-pear",
      "6.3" => "php53u-pear",
      "default" => "php-pear"
    },
    "ubuntu" => {
      "default" => "php-pear"
    },
    "default" => "php-pear"
  )
  action :install
end

log "  Install PHP apache support"
package "php apache integration" do
  package_name value_for_platform(
    [ "centos", "redhat" ] => {
      "5.6" => "php53u-zts",
      "5.7" => "php53u-zts",
      "5.8" => "php53u-zts",
      "6.2" => "php53u-zts",
      "6.3" => "php53u-zts",
      "default" => "php-zts"
    },
    "ubuntu" => {
      "default" => "libapache2-mod-php5"
    },
    "default" => "php-zts"
  )
  action :install
end

# We do not care about version number here.
# need only the type of database adaptor
node[:app][:db_adapter] = node[:db][:provider_type].match(/^db_([a-z]+)/)[1]

if node[:app][:db_adapter] == "mysql"
  log "  Install PHP mysql support"
  package "php mysql integration" do
    package_name value_for_platform(
      [ "centos", "redhat" ] => {
        "5.6" => "php53u-mysql",
        "5.7" => "php53u-mysql",
        "5.8" => "php53u-mysql",
        "6.2" => "php53u-mysql",
        "6.3" => "php53u-mysql",
        "default" => "php-mysql"
      },
      "ubuntu" => {
        "default" => "php5-mysql"
      },
      "default" => "php-mysql"
    )
    action :install
  end
elsif node[:app][:db_adapter] == "postgres"
  log "  Install PHP postgres support"
  package "php postgres integration" do
    package_name value_for_platform(
      [ "centos", "redhat" ] => {
        "5.6" => "php53u-pgsql",
        "5.7" => "php53u-pgsql",
        "5.8" => "php53u-pgsql",
        "6.2" => "php53u-pgsql",
        "6.3" => "php53u-pgsql",
        "default" => "php-pgsql"
      },
      "ubuntu" => {
        "default" => "php5-pgsql"
      },
      "default" => "php5-pgsql"
    )
    action :install
  end
else
  raise "Unrecognized database adapter #{node[:app][:db_adapter]}, exiting"
end

remote_file "/tmp/mediawiki-1.19.2.tar.gz" do
  source "http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.2.tar.gz"
  notifies :run, "bash[install_program]", :immediately
end

bash "install_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
tar -zxf mediawiki-1.19.2.tar.gz
(cp -a mediawiki-1.19.2/* /home/webapp/mediawiki/ && rm -rf mediawiki-1.19.2*)
EOH
  action :nothing
end
node[:app_mediawiki][:admin_user] = node[:db][:application][:user]
node[:app_mediawiki][:admin_pass] = node[:db][:application][:password]
node[:app_mediawiki][:dbname] = node[:db][:dump][:database_name]


template "/home/webapp/mediawiki/LocalSettings.php" do
# Writing settings to mediawiki configuration template.
  source "LocalSettings.erb"
  cookbook "app_mediawiki"
  variables(
    :fqdn => node[:app_mediawiki][:fqdn],
    :namespace => node[:app_mediawiki][:namespace],
    :admin_email => node[:app_mediawiki][:admin_email],
    :admin_user => node[:app_mediawiki][:admin_user],
    :admin_pass => node[:app_mediawiki][:admin_pass],
    :dbname => node[:app_mediawiki][:dbname]
  )
end

# Setting app LWRP attribute
node[:app][:destination] = "/home/webapp/mediawiki"

# PHP shares the same doc root with the application destination
node[:app][:root] = "#{node[:app][:destination]}"


rightscale_marker :end
