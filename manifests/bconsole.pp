
class bareos::bconsole (
    $director_name,
    $port,
    $address,
    $password,
    $user          = $params::user,
    $group         = $params::group,
    $conf          = $params::bconsole_conf,
    $package_name  = $params::bconsole_package,
) inherits params {

    include repo
    
    package {$package_name:
        ensure  => installed,
        require => $repo::require,
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
        order   => '05',
        content => template('bareos/bconsole.conf.erb'),
    }

}
