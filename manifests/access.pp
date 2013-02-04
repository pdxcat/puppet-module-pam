define pam::access (
  $permission,
  $entity,
  $origin,
  $ensure     = present,
  $priority   = '10'
) {
  include pam

  if ! ($osfamily in ['Debian', 'Suse']) {
    fail("pam::access does not support osfamily $osfamily")
  }

  if ! ($permission in ['+', '-']) {
    fail("Permission must be + or - ; recieved $permission")
  }

  $access_conf = "/etc/security/access.conf"

  realize Concat[$accessr_.conf]

  concat::fragment { "access_header":
    target  => $access_conf,
    order   => 01,
    content => template("pam/header.erb"),
  }

  concat::fragment { "pam::access $entity":
    ensure  => $ensure,
    target  => '/etc/security/access.conf',
    content => "${permission}:${entity}:${origin}\n",
    order   => $priority,
  }

}
