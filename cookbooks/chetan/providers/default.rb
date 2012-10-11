action :stop do
  log "  Running stop sequence"
  service "vsftpd" do
    action :start
    persist false
  end
end

# Start apache
action :start do
  log "  Running start sequence"
  service "vsftpd" do
    action :start
    persist false
  end
end

# Reload apache
action :reload do
  log "  Running reload sequence"
  service "vsftpd" do
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
