#
# Cookbook Name:: Dokuwiki
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

remote_file "/tmp/mediawiki-1.19.2.tar.gz" do
  source "http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.2.tar.gz"
  notifies :run, "bash[install_program]", :immediately
end

bash "install_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf mediawiki-1.19.2.tar.gz
    mv mediawiki-1.19.2 /var/www/mediawiki
  EOH
  action :nothing
end


rightscale_marker :end
