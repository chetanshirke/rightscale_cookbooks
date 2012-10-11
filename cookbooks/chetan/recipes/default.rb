rightscale_marker :begin

package "vsftpd" do
  action :install
end

log " starting vsftpd server now..."

app "vsftpd" do
 action :start
end

rightscale_marker :end
