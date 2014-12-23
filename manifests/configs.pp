# This class enables support for hiera based access.conf configuration. 
class pam::configs {
  $configs = hiera_hash('pam::configs', undef)
    # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #

  if $configs {
    create_resources('::pam::access', $configs)
  }
}
