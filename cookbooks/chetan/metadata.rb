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

recipe  "chetan::default", "Installs the vsftpd application server."
recipe  "chetan::do_stop", "Stops service."

attribute "vsftpd",
  :display_name => "General vsftpd Options",
  :type => "hash"

attribute "package name",
  :display_name => "package name",
  :description => "package name to install",
  :required => "required",
  :recipes => [ "chetan::default" ]
