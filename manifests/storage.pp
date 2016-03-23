
class bareos::storage (
    $storage_name       = "${::hostname}-sd",
    $director_name,
    $director_password,
    $max_conc_jobs      = 20,
    $default_messages   = true,
    $plugins_dir        = $params::plugins_dir,
    $plugins            = [],
    $options            = {},
    $user               = $params::user,
    $group              = $params::group,
    $conf               = $params::storage_conf,
    $conf_d             = $params::storage_conf_d,
    $package_name       = $params::storage_package,
    $service_name       = $params::storage_service,
) inherits params {

    include repo
    
    package {$storage_package:
        ensure  => installed,
        require => $repo::require,
    }
    
    ->
    
    service {$service_name:
        ensure => running,
    }
    
    concat {$conf:
        ensure  => present,
        owner   => $user,
        group   => $group,
        mode    => '0640',
        require => Package[$package_name],
        notify  => Service[$service_name],
    }
    
    concat::fragment {$conf:
        target  => $conf,
        order   => '01',
        content => template('bareos/bareos-sd.conf.erb'),
    }
    
    storage::director {$director_name:
        password => $director_password,
    }
    
    if $default_messages {
        storage::messages {'Standard':
            options       => {
                'Director' => "${director_name} = all",
            },
        }
    }
    
    
    file {$conf_d:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => Package[$package_name],
    }

    $devices_conf = "${conf_d}/devices.conf"
    concat::fragment {"${conf}+${devices_conf}":
        target  => $conf,
        order   => '15',
        content => "@${devices_conf}\n",
    }
    concat {$devices_conf:
        ensure  => present,
        owner   => $user,
        group   => $group,
        mode    => '0640',
        notify  => Service[$service_name],
        require => File[$conf_d],
    }
    concat::fragment {$devices_conf:
        target  => $devices_conf,
        order   => '01',
        content => "# Managed by puppet!\n",
    }

}
