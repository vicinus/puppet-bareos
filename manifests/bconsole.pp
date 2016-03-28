
class bareos::bconsole (
    $director_name = undef,
    $password      = $params::dummy_password,
    $address       = undef,
    $port          = $params::director_port,
    $user          = $params::user,
    $group         = $params::group,
    $conf          = $params::bconsole_conf,
    $package_name  = $params::bconsole_package,
) inherits params {

    include global
    include repo
    include bareos
    
    package {$package_name:
        ensure  => $global::package_ensure,
        require => $repo::require,
        before  => File[$bareos::confdir],
    }
    
    concat {$conf:
        ensure  => present,
        owner   => $user,
        group   => $group,
        mode    => '0640',
        require => Package[$package_name],
    }

    concat::fragment {$conf:
        target  => $conf,
        order   => '01',
        content => "# Managed by puppet !\n",
    }
    
    if $director_name {

        bconsole::director {$director_name:
            password => $password,
            address  => $address,
            port     => $port,
        }

    }

}
