
class bareos::bconsole (
    $director_name = undef,
    $password      = $bareos::params::dummy_password,
    $address       = undef,
    $port          = $bareos::params::director_port,
    $user          = $bareos::params::user,
    $group         = $bareos::params::group,
    $conf          = $bareos::params::bconsole_conf,
    $package_name  = $bareos::params::bconsole_package,
) inherits bareos::params {

    include bareos
    include bareos::global
    include bareos::repo
    
    package {$package_name:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
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

        bareos::bconsole::director {$director_name:
            password => $password,
            address  => $address,
            port     => $port,
        }

    }

}
