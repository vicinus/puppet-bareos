
class bareos::director (
    $director_name      = "${::hostname}-dir",
    $director_password, # console (main?) password
    $monitor_name       = undef,
    $monitor_password   = undef, # console (main?) password
    $daemon_name        = "${::hostname}-fd",
    $daemon_password,
    $load_backends      = false,
    $user               = $params::user,
    $group              = $params::group,
    $conf               = $params::director_conf,
    $conf_d             = $params::director_conf_d,
    $backend_dir        = $params::director_backend_dir,
    $package_name       = $params::director_package,
    $service_name       = $params::director_service,
) inherits params {

    include repo
    
    package {$package_name:
        ensure  => installed,
        require => $repo::require,
    }
    
    ->
    
    service {$service_name:
        ensure => running,
    }
    
    
    class {'filedaemon':
        director_name     => $director_name,
        director_password => $daemon_password,
        daemon_name       => $daemon_name,
    }

    concat {$params::director_conf:
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
        ensure => directory,
        owner  => $user,
        group  => $group,
        mode   => '0755',
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
    
    # Console
    $console_conf = "${conf_d}/console.conf"
    director::bresource {'console':
        conf => $console_conf,
    }

}
