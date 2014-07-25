# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
# Licensed under the Apache License, Version 2.0 (the "License");
# http://www.apache.org/licenses/LICENSE-2.0
#

# == Class: mysql_hardening::puppetlabs
#
# Overlay provider for puppetlabs/mysql
#
# === Parameters
#
# none
#
class mysql_hardening::puppetlabs(
) {
  # hardening options
  $hardening_oo = {

    mysqld => {
      automatic_sp_privileges => '0',
      safe-user-create => '1',
      skip-symbolic-links => '1',
      secure-auth => '1',
      local-infile => '0',
      skip-show-database => true,
      secure-file-priv => '/tmp',
      allow-suspicious-udfs => '0'
    }
  }

  # get the override options the user specifies
  $org_oo = getparam(Class['::mysql::server'], 'override_options')

  # now lay hardening on top
  $new_options = merge_hardening( $org_oo, $hardening_oo )

  # finally we need to make sure our options are written to the config file
  class{'mysql_hardening::puppetlabs_override': }
}
