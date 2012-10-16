maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs /home directory"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "13.2.0"

# supports "centos", "~> 5.8", "~> 6"
# supports "redhat", "~> 5.8"
# supports "ubuntu", "~> 10.04", "~> 12.04"

depends "rightscale"

recipe  "vsftpd::default", "Installs the vsftpd application server."
recipe  "vsftpd::do_stop", "Stops service."

attribute "vsftpd",
  :display_name => "Import/export settings for database dump file management.",
  :type => "hash"

attribute "vsftpd/tcp_port",
  :display_name => "Vsftpd TCP Port",
  :description => "The TCP port to use for connections. Default : 21",
  :required => "recommended",
  :default => "21",
  :recipes => ["vsftpd::default"]

attribute "vsftpd/user",
  :display_name => "Vsftpd user",
  :description => "The user for executing vsftpd. Default: YES",
  :required => "recommended",
  :choice => [ "YES", "NO" ],
  :default => "YES",
  :recipes => ["vsftpd::default"]

attribute "vsftpd/interface",
  :display_name => "Vsftpd listening interface",
  :description => "Interface used for memcached connections. Default: any",
  :required => "recommended",
  :default => "any",
  :recipes => ["vsftpd::default"]
