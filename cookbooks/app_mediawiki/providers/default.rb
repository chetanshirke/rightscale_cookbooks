#
# Cookbook Name:: app_mediawiki
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Stop apache
action :stop do
  log " Running stop sequence"
  service "apache2" do
    action :start
    persist false
  end
end

# Start apache
action :start do
  log " Running start sequence"
  service "apache2" do
    action :start
    persist false
  end
end

# Reload apache
action :reload do
  log " Running reload sequence"
  service "apache2" do
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

# Install Packages and Modules required for PHP application server.
action :install do
  # Installing required packages
  packages = new_resource.packages
 
  if not packages.nil?
    log " Packages which will be installed #{packages}"

    packages.each do |p|
      package p
    end
  end

  # Installing user-specified additional php modules
  log " Modules which will be installed: #{node[:app_mediawiki][:modules_list]}"
  node[:app_mediawiki][:modules_list].each do |p|
    package p
  end

  # Installing php modules dependencies
  log " Module dependencies which will be installed: #{node[:app][:module_dependencies]}"
  node[:app][:module_dependencies].each do |mod|
    apache_module mod
  end

end


# Setup apache PHP virtual host
action :setup_vhost do

  project_root = node[:app][:destination]
  php_port = new_resource.port
  
  # Disable default vhost
  apache_site "000-default" do
    enable false
  end

  # Adds php port to list of ports for webserver to listen on
  app_add_listen_port php_port

  # Configure apache vhost for PHP
  web_app node[:web_apache][:application_name] do
    template "app_server.erb"
    docroot project_root
    vhost_port php_port.to_s
    server_name node[:web_apache][:server_name]
    cookbook "web_apache"
  end

end


# Setup PHP Database Connection
action :setup_db_connection do
  project_root = new_resource.destination
  db_name = new_resource.database_name
  # Make sure config dir exists
  directory ::File.join(project_root, "config") do
    recursive true
    owner node[:app][:user]
    group node[:app][:group]
  end

  # Tells selected db_adapter to fill in it's specific connection template
  db_connect_app ::File.join(project_root, "config", "db.php") do
    template "db.php.erb"
    cookbook "app_mediawiki"
    database db_name
    owner node[:app][:user]
    group node[:app][:group]
  end
end

action :code_update do

  log "  Starting code update sequence"
  log "  Downloading project from download_url"

  package_name = node[:app_mediawiki][:download_url].split('/').last
  local_folder = "#{package_name}".split('.')
  local_folder = "#{local_folder[0]}.#{local_folder[1]}.#{local_folder[2]}"
 
  remote_file"/tmp/#{package_name}" do
        source "#{node[:app_mediawiki][:download_url]}"
        notifies :run, "bash[install_program]", :immediately
  end

  bash "install_program" do
    user "root"
    cwd "/tmp" 
    code <<-EOH
    tar -zxf #{package_name} -C "#{node[:app][:destination]}"
    EOH
  action :nothing
  end

  template "#{node[:app][:destination]}/#{local_folder}/LocalSettings.php" do
  # Writing settings to mediawiki configuration template.
  source "LocalSettings.erb"
  mode "0644"
  cookbook "app_mediawiki"
  variables(
    :app_fqdn => node[:app_mediawiki][:dns][:app_fqdn],
    :script_path => "/#{local_folder}",
    :namespace => node[:app_mediawiki][:namespace]
  )
 end

 template "#{node[:app][:destination]}/index.html" do
   action :create
   source "ha_test_page.erb"
   cookbook "app_mediawiki"
 end

 # Restarting apache service.
 action_restart
end

action :setup_monitoring do

  log "  Monitoring resource is not implemented in php framework yet. Use apache monitoring instead."

end
