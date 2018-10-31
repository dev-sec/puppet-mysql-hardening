# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
# Licensed under the Apache License, Version 2.0 (the "License");
# http://www.apache.org/licenses/LICENSE-2.0
#

# == Class: mysql_hardening::puppetlabs_override
#
# Overlay provider for puppetlabs/mysql
#
# === Parameters
#
# none
#
class mysql_hardening::puppetlabs_override inherits ::mysql::server::config {
  # merges the final set of options
  $options = mysql::deepmerge( $::mysql::server::options, $::mysql_hardening::puppetlabs::new_options )
  # write the new template
  if defined(File['mysql-config-file']) {
    $mysql_config_filename = 'mysql-config-file'
  } else {
    $mysql_config_filename = $mysql::server::config_file
  }

  File[$mysql_config_filename]{
    content => template('mysql/my.cnf.erb'),
    mode   => '0640',
  }
}
