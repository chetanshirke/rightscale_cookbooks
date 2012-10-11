package "vsftpd" do
  action :install
end

log " starting vsftpd server now..."

app "vsftpd" do
 action :start
end

