# === Copyright
#
# Copyright 2014, Deutsche Telekom AG
# Licensed under the Apache License, Version 2.0 (the "License");
# http://www.apache.org/licenses/LICENSE-2.0
#

# == Class: mysql_hardening
#
# Configures overlay hardening
#
# === Parameters
#
# [*mysql_provider*]
#   The name of the provider you use to install MySQL.
#   Supported: `puppetlabs/mysql`
#
class mysql_hardening(
  $provider = 'none',
) {
  case $provider {
    'puppetlabs/mysql': {
      class{'mysql_hardening::puppetlabs': }
    }
    'none': {
      fail('You haven\'t configured a MySQL provider for hardening.')
    }
    default: {
      fail('Unrecognized/Unsupported MySQL provider for hardening.')
    }
  }
}
