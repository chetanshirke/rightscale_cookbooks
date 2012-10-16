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

case node[:vsftpd][:interface]
when "localhost"
  # Note: not using "localhost" because value also goes into collectd plugin which doesn't understand it.
  node[:vsftpd][:interface] = "127.0.0.1"
when "private"
  # When binding to private on aws you also listen to public because of amazons traffic forwarding.
  node[:vsftpd][:interface] = node[:cloud][:private_ips][0]
when "any"
  node[:vsftpd][:interface] = "0.0.0.0"
end

template "/etc/vsftpd/vsftpd.conf" do
# Writing settings to vsftpd configuration template.
  source "vsftpd.erb"
  cookbook "vsftpd"
  variables(
    :tcp_port => node[:vsftpd][:tcp_port],
    :user => node[:vsftpd][:user]
  )
end

log "  Vsftpd configuration done."

service "vsftpd" do
  action :start
end

rightscale_marker :end
