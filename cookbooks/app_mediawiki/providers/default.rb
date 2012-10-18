#
# Cookbook Name:: chetan
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# = Default application server provider
#

action :stop do
  log "  Running stop sequence"
  service "mediawiki" do
    action :stop
    persist false
  end
end

# Start apache
action :start do
  log "  Running start sequence"
  service "mediawiki" do
    action :start
    persist false
  end
end

# Reload apache
action :reload do
  log "  Running reload sequence"
  service "mediawiki" do
    action :reload
    persist false
  end
end

# Restart apache
action :restart do
  action_stop
  sleep 5
  action_start
end

action :install do
  # Installing required packages
  packages = new_resource.packages

  if not packages.nil?
    log "  Packages which will be installed #{packages}"

    packages.each do |p|
      package p
    end
  end
end
