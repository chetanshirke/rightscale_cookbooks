#
# Cookbook Name:: app_mediawiki
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.


# Downloading app from URL

  pn = node[:app_mediawiki][:download_url]
  package_name = pn.split('/')

  remote_file"/tmp/#{package_name.last}" do
        source "node[:app_mediawiki][:download_url]"
        notifies :run, "bash[install_program]", :immediately
  end

  bash "install_program" do
    user "root"
    cwd "/tmp"
    code <<-EOH
    tar -zxf #{package_name.last} -C "node[:app][:destination]"
    EOH
  action :nothing
  end

