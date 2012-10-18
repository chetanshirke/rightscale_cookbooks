#
# Cookbook Name:: Dokuwiki
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

  bash "install_mediawiki" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  /usr/bin/wget http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.2.tar.gz
  /bin/tar -zxf /tmp/mediawiki-1.19.2.tar.gz
  /bin/mv mediawiki-1.19.2 /var/www/mediawiki
    EOH
  action :nothing
  end

rightscale_marker :end
