#
# Cookbook Name:: chetan
# Resource:: chetan::default
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.


# Install packages required for application server setup
actions :install
  # Set of packages to be installed in addition to the base application packages.
  attribute :packages, :kind_of => Array

# Runs application server start sequence
actions :start

# Runs application server stop sequence
actions :stop

# Runs application server restart sequence
actions :restart

# Runs application server reload sequence
actions :reload

