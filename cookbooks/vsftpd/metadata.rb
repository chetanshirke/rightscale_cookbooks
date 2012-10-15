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

attribute "vsftpd/port",
  :display_name => "port number",
  :description => "Please provide port number",
  :required => "optional",
  :choice => [
    "21",
    "23",
    "24"
  ],
  :recipes => [ "vsftpd::default" ]
