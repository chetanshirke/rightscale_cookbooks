rightscale_marker :begin

package "vsftpd" do
  action :install
end

app "vsftpd" do
 action :start
end

rightscale_marker :end
