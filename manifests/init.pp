class pam {
  include concat::setup
  if (versioncmp($::puppetversion, '3') != -1) {
    include 'pam::configs'
  }

  @concat { '/etc/security/access.conf':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  @concat { '/etc/security/limits.conf':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
}
