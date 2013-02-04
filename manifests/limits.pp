define pam::limits (
  $domain,
  $type,
  $item,
  $value,
  $ensure   = present,
  $priority = '10'
) {
  include pam

  if ! ($osfamily in ['Debian', 'Suse']) {
    fail("pam::limits does not support osfamily $osfamily")
  }

  $limits_conf = "/etc/security/limits.conf"

  realize Concat[$limits_conf]

  concat::fragment { "limits_header":
    target  => $limits_conf,
    order   => 01,
    content => template("pam/header.erb"),
  }

  concat::fragment { "pam::limits ${domain}-${type}-${item}-${value}":
    ensure  => $ensure,
    target  => $limits_conf,
    content => "${domain} ${type} ${item} ${value}\n",
    order   => $priority,
  }

}
