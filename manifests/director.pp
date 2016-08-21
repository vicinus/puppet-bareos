
class bareos::director (
    $director_name,
    $director_password,
    $port               = $bareos::params::director_port,
    $query_file         = $bareos::params::director_query_file,
    $load_backends      = false,
    $backend_dir        = $bareos::params::director_backend_dir,
    $plugins_dir        = $bareos::params::plugins_dir,
    $plugins            = [],
    $options            = {},
    $user               = $bareos::params::user,
    $group              = $bareos::params::group,
    $conf               = $bareos::params::director_conf,
    $conf_d             = $bareos::params::director_conf_d,
    $package_name       = $bareos::params::director_package,
    $service_name       = $bareos::params::director_service,
) inherits bareos::params {

    include bareos
    include bareos::global
    include bareos::repo
    
    package {$package_name:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
        before  => File[$bareos::confdir],
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
        content => template('bareos/bareos-dir.conf.erb'),
    }

    file {$conf_d:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => Package[$package_name],
    }
    
    file {$bareos::params::datadir:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => Package[$package_name],
    }
    
    # Clients
    $clients_conf = "${conf_d}/clients.conf"
    bareos::director::bresource {'clients':
        conf => $clients_conf,
    }

    # Storages
    $storages_conf = "${conf_d}/storages.conf"
    bareos::director::bresource {'storages':
        conf => $storages_conf,
    }
    
    # Jobs
    $jobs_conf = "${conf_d}/jobs.conf"
    bareos::director::bresource {'jobs':
        conf => $jobs_conf,
    }

    # Catalogs
    $catalogs_conf = "${conf_d}/catalogs.conf"
    bareos::director::bresource {'catalogs':
        conf => $catalogs_conf,
    }

    # Pools
    $pools_conf = "${conf_d}/pools.conf"
    bareos::director::bresource {'pools':
        conf => $pools_conf,
    }

    # Schedules
    $schedules_conf = "${conf_d}/schedules.conf"
    bareos::director::bresource {'schedules':
        conf => $schedules_conf,
    }

    # Messages
    $messages_conf = "${conf_d}/messages.conf"
    bareos::director::bresource {'messages':
        conf => $messages_conf,
    }
    
    # Profiles
    $profile_conf = "${conf_d}/profile.conf"
    bareos::director::bresource {'profile':
        conf => $profile_conf,
    }

    # Consoles
    $consoles_conf = "${conf_d}/consoles.conf"
    bareos::director::bresource {'console':
        conf => $consoles_conf,
    }

    # Filesets
    $filesets_conf = "${conf_d}/filesets.conf"
    bareos::director::bresource {'fileset':
        conf => $filesets_conf,
    }
}
