#
# Cookbook Name:: app_mediawiki
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.


  # Downloading app from URL
log node[:app][:db_adapter]
log node[:db][:dns][:master][:fqdn]
log node[:db][:dump][:database_name]
log node[:db][:admin][:user]
log node[:db][:admin][:password]
