#
# Cookbook Name:: app_mediawiki
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.


  # Downloading app from URL
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

node[:app_mediawiki][:interface] = node[:cloud][:private_ips][0]

template "/home/webapp/mediawiki/LocalSettings.php" do
# Writing settings to mediawiki configuration template.
  source "LocalSettings.erb"
  cookbook "app_mediawiki"
  variables(
    :app_name => node[:app_mediawiki][:namespace],
    :namespace => node[:app_mediawiki][:namespace],
    :interface => node[:app_mediawiki][:interface],
    :admin_user => node[:app_mediawiki][:admin_user],
    :admin_pass => node[:app_mediawiki][:admin_pass],
    :admin_email => node[:app_mediawiki][:admin_email]
  )
end

