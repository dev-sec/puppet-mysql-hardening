# == Class: mysql_hardening::puppetlabs_override
#
# Overlay provider for puppetlabs/mysql
#
# === Parameters
#
# none
#
# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
#

class mysql_hardening::puppetlabs_override inherits ::mysql::server::config {
  # merges the final set of options
  $options = mysql_deepmerge( $::mysql::server::options, $::mysql_hardening::puppetlabs::new_options )
  # write the new template
  File[$mysql::server::config_file]{
    content => template('mysql/my.cnf.erb')
  }
}
