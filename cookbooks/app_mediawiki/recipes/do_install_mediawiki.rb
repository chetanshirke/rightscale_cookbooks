#
# Cookbook Name:: app_mediawiki
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.


  # Downloading app from URL

package_name = "[:app_mediawiki][:download_url] | awk -F"/" '{print $(NF-0)}'"
file_name =  "#{package_name} | cut -d. -f1,2,3"

remote_file "/tmp/#{package_name}" ;do
	source "[:app_mediawiki][:download_url]"
	notifies :run, "bash[install_program]", :immediately
end

bash "install_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxf #{package_name}
  cp -a #{file_name} "#node[:app][:destination]" && rm -rf #{file_name}*
   EOH
  action :nothing
end
