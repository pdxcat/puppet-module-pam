class pam {
  include concat::setup

  $access_conf = '/etc/security/access.conf'
  $limits_conf = '/etc/security/limits.conf'

  # pam_access
  @concat { $access_conf:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # pam_limits
  @concat { $limits_conf:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # header
  @concat::fragment { "header":
    target  => undef,
    order   => 01,
    content => template("pam/header.erb"),
  }
}
