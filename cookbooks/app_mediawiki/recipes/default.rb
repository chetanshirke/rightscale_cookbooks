#
# Cookbook Name:: Dokuwiki
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

  directory "/home/webapp" do
    owner node[:root][:user]
    group node[:root][:group]
    action :create
    recursive true
    not_if "test -d /home/webapp"
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
    (cp -a  mediawiki-1.19.2 /home/webapp/mediawiki && rm -rf  mediawiki-1.19.2*)
  EOH
  action :nothing
end

case node[:app_mediawiki][:interface]
when "localhost"
  # Note: not using "localhost" because value also goes into collectd plugin which doesn't understand it.
  node[:app_mediawiki][:interface] = "127.0.0.1"
when "private"
  # When binding to private on aws you also listen to public because of amazons traffic forwarding.
  node[:app_mediawiki][:interface] = node[:cloud][:private_ips][0]
when "any"
  node[:app_mediawiki][:interface] = "0.0.0.0"
end

template "/var/www/mediawiki/LocalSettings.php" do
# Writing settings to mediawiki configuration template.
  source "LocalSettings.erb"
  cookbook "app_mediawiki"
  variables(
    :app_name => node[:app_mediawiki][:app_name],
    :namespace => node[:app_mediawiki][:namespace],
    :interface => node[:app_mediawiki][:interface],
    :admin_user => node[:app_mediawiki][:admin_user],
    :admin_pass => node[:app_mediawiki][:admin_pass],
    :admin_email => node[:app_mediawiki][:admin_email]
  )
end

rightscale_marker :end
