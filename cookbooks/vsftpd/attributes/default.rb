#
# Cookbook Name:: vsftpd
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Set a default provider for app to connect with lb cookbook attach/detach
# for application servers without their own provider.
set_unless[:vsftpd][:tcp_port] = "21"
set_unless[:vsftpd][:user] = "anonymous"
