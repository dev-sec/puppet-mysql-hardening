# == Class: mysql_hardening::puppetlabs
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
class mysql_hardening::puppetlabs(
) {
  # hardening options
  $hardening_oo = {
    mysqld => {
      automatic_sp_privileges => '0',
      safe-user-create => '1',
      secure-auth => '1',
      skip-show-database => true,
      secure-file-priv => '/tmp',
      skip-symbolic-links => true,
    }
  }

  # get the override options the user specifies
  $org_oo = getparam(Class['::mysql::server'], 'override_options')

  # now lay hardening on top
  $new_options = merge_hardening( $org_oo, $hardening_oo )

  # finally we need to make sure our options are written to the config file
  class mysql_hardening::puppetlabs_override inherits ::mysql::server::config {
    # merges the final set of options
    $options = mysql_deepmerge( $::mysql::server::options, $::mysql_hardening::puppetlabs::new_options )
    # write the new template
    File[$mysql::server::config_file]{
      content => template('mysql/my.cnf.erb')
    }
  }
  class{'mysql_hardening::puppetlabs_override': }
}
