
class bareos::director (
    $director_name,
    $director_password, # console (main?) password
    $query_file         = $params::director_query_file,
    $load_backends      = false,
    $backend_dir        = $params::director_backend_dir,
    $plugins_dir        = $params::plugins_dir,
    $plugins            = [],
    $options            = {},
    $user               = $params::user,
    $group              = $params::group,
    $conf               = $params::director_conf,
    $conf_d             = $params::director_conf_d,
    $package_name       = $params::director_package,
    $service_name       = $params::director_service,
) inherits params {

    include global
    include repo
    
    package {$package_name:
        ensure  => $global::package_ensure,
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
        content => template('bareos/bareos-dir.conf.erb'),
    }

    file {$conf_d:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => Package[$package_name],
    }
    
    file {$params::datadir:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => Package[$package_name],
    }
    
    # Clients
    $clients_conf = "${conf_d}/clients.conf"
    director::bresource {'clients':
        conf => $clients_conf,
    }

    # Storages
    $storages_conf = "${conf_d}/storages.conf"
    director::bresource {'storages':
        conf => $storages_conf,
    }
    
    # Jobs
    $jobs_conf = "${conf_d}/jobs.conf"
    director::bresource {'jobs':
        conf => $jobs_conf,
    }

    # Jobdefs
    $jobdefs_conf = "${conf_d}/jobdefs.conf"
    director::bresource {'jobdefs':
        conf => $jobdefs_conf,
    }

    # Catalogs
    $catalogs_conf = "${conf_d}/catalogs.conf"
    director::bresource {'catalogs':
        conf => $catalogs_conf,
    }

    # Pools
    $pools_conf = "${conf_d}/pools.conf"
    director::bresource {'pools':
        conf => $pools_conf,
    }

    # Schedules
    $schedules_conf = "${conf_d}/schedules.conf"
    director::bresource {'schedules':
        conf => $schedules_conf,
    }

    # Messages
    $messages_conf = "${conf_d}/messages.conf"
    director::bresource {'messages':
        conf => $messages_conf,
    }
    
    # Profiles
    $profile_conf = "${conf_d}/profile.conf"
    director::bresource {'profile':
        conf => $profile_conf,
    }

    # Consoles
    $consoles_conf = "${conf_d}/consoles.conf"
    director::bresource {'console':
        conf => $consoles_conf,
    }

    # Filesets
    $filesets_conf = "${conf_d}/filesets.conf"
    director::bresource {'fileset':
        conf => $filesets_conf,
    }
}
