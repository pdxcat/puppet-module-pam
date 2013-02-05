define pam::limits (
  $domain,
  $type,
  $item,
  $value,
  $ensure   = present,
  $priority = '10'
) {
  include pam

  if ! ($::osfamily in ['Debian', 'RedHat', 'Suse']) {
    fail("pam::limits does not support osfamily $::osfamily")
  }

  $limits_conf = $pam::limits_conf

  realize ( Concat[$limits_conf] )
  Concat::Fragment <| title == 'header' |> { target => $limits_conf }

  concat::fragment { "pam::limits ${domain}-${type}-${item}-${value}":
    ensure  => $ensure,
    target  => $limits_conf,
    content => "${domain} ${type} ${item} ${value}\n",
    order   => $priority,
  }

}
