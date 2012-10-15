#
# Cookbook Name:: vsftpd
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

# The instance is identified as a vsftpd server.
#right_link_tag "vsftpd_server:active=true"
# The server name so that sorts can be done to get the correct order across app servers.
#right_link_tag "vsftpd_server:uuid=#{node[:rightscale][:instance_uuid]}"
# The instance is associated with a cluster
#right_link_tag "vsftpd_server:cluster=#{node[:vsftpd][:cluster_id]}"
# The listening port
#right_link_tag "vsftpd_server:port=#{node[:vsftpd][:tcp_port]}"


package "vsftpd" do
  action :install
end

# Initializing supported commands for vsftpd services for further usage.
service "vsftpd" do
  # We need the service to autostart after reboot.
  action :enable
  persist true
  supports :status => true, :start => true, :stop => true, :restart => true
end

# Writing settings to vsftpd configuration template.
  source "vsftpd.erb"
  variables(
    :tcp_port => node[:vsftpd][:tcp_port],
    :user => node[:vsftpd][:user]
  )

log "  Vsftpd configuration done."

service "vsftpd" do
  # We need the service to autostart after reboot.
  action :start
  supports :status => true, :start => true, :stop => true, :restart => true
end


rightscale_marker :end
