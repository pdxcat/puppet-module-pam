define pam::access (
  $permission,
  $entity,
  $origin,
  $ensure     = present,
  $priority   = '10'
) {
  include pam

  if ! ($::osfamily in ['Debian', 'RedHat', 'Suse']) {
    fail("pam::access does not support osfamily $::osfamily")
  }

  if ! ($permission in ['+', '-']) {
    fail("Permission must be + or - ; recieved $permission")
  }

  $access_conf = $pam::access_conf

  realize Concat[$access_conf]
  Concat::Fragment <| title == 'header' |> { target => $access_conf }

  concat::fragment { "pam::access $entity":
    ensure  => $ensure,
    target  => $access_conf,
    content => "${permission}:${entity}:${origin}\n",
    order   => $priority,
  }

}
