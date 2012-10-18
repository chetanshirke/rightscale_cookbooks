#
# Cookbook Name:: mediawiki
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Set a default provider for app to connect with lb cookbook attach/detach
# for application servers without their own provider.
set_unless[:app_mediawiki][:app_name] = "default"
set_unless[:app_mediawiki][:namespace] = "default"
set_unless[:app_mediawiki][:interface] = "any"
set_unless[:app_mediawiki][:admin_user] = "admin"
set_unless[:app_mediawiki][:admin_pass] = "admin123"
set_unless[:app_mediawiki][:email_account] = "root@localhost"
