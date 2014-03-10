class balancer (
  $host_name,
  $members = [],
  $proxy_name = 'default',
) {
  #################################
  # services
  
  class { 'nginx': }
  
  nginx::resource::upstream { $proxy_name:
    ensure  => present,
    members => $members
  }

  nginx::resource::vhost { $host_name:
    ensure => present,
    proxy  => "http://$proxy_name",	
  }

  firewall { '100 allow http and https access':
    port   => [80, 443],
    proto  => tcp,
    action => accept,
  }
}
