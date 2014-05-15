# == Class: mysql_hardening::puppetlabs
#
# Overlay provider for puppetlabs/mysql
#
# === Parameters
#
# ...
#
# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
#
class mysql_hardening::puppetlabs(
) {
  # hardening options
  $hardening_oo = {
    # ...
  }

  # override_options
  $org_oo = getparam(Class['::mysql::server'], "override_options")
  $nu_oo = merge_hardening( $org_oo, $hardening_oo )

  # Resource-usage mode
  Class['::mysql::server'] {
    override_options => $nu_oo
  }
}
