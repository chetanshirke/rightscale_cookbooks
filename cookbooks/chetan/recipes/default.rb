rightscale_marker :begin

package "vsftpd" do
  action :install
end

chetan "vsftpd" do
 action :start
end

rightscale_marker :end
