
class bareos::director (
    $director_name      = "${::hostname}-dir",
    $director_password, # console (main?) password
    $monitor_name       = undef,
    $monitor_password   = undef, # console (main?) password
    $daemon_name        = "${::hostname}-fd",
    $daemon_password,
    $load_backends      = false,
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
        owner   => $params::user,
        group   => $params::group,
        mode    => '0640',
        require => Package[$package_name],
        notify  => Service[$service_name],
    }

    concat::fragment {$params::director_conf:
        target  => $params::director_conf,
        order   => '01',
        content => template('bareos/bareos-dir.conf.erb'),
    }

    file {$params::director_conf_d:
        ensure  => directory,
        owner   => $params::user,
        group   => $params::group,
        mode    => '0755',
        require => Package[$package_name],
    }
    
    file {$params::datadir:
        ensure => directory,
        owner  => $params::user,
        group  => $params::group,
        mode   => '0755',
    }
    
    # TODO extract into helper resource ?
    
    $managed = "# Managed by puppet!\n"

    # Clients
    $clients_conf = "${params::director_conf_d}/clients.conf"
    concat::fragment {"${params::director_conf}+${clients_conf}":
        target  => $params::director_conf,
        order   => '10',
        content => "@${clients_conf}\n",
    }
    concat {$clients_conf:
        ensure  => present,
        owner   => $params::user,
        group   => $params::group,
        mode    => '0640',
        notify  => Service[$service_name],
        require => File[$params::director_conf_d],
    }
    concat::fragment {$clients_conf:
        target  => $clients_conf,
        order   => '01',
        content => $managed,
    }

    # Storages
    $storages_conf = "${params::director_conf_d}/storages.conf"
    concat::fragment {"${params::director_conf}+${storages_conf}":
        target  => $params::director_conf,
        order   => '10',
        content => "@${storages_conf}\n",
    }
    concat {$storages_conf:
        ensure  => present,
        owner   => $params::user,
        group   => $params::group,
        mode    => '0640',
        notify  => Service[$service_name],
        require => File[$params::director_conf_d],
    }
    concat::fragment {$storages_conf:
        target  => $storages_conf,
        order   => '01',
        content => $managed,
    }

    # Catalogs
    $catalogs_conf = "${params::director_conf_d}/catalogs.conf"
    concat::fragment {"${params::director_conf}+${catalogs_conf}":
        target  => $params::director_conf,
        order   => '10',
        content => "@${catalogs_conf}\n",
    }
    concat {$catalogs_conf:
        ensure  => present,
        owner   => $params::user,
        group   => $params::group,
        mode    => '0640',
        notify  => Service[$service_name],
        require => File[$params::director_conf_d],
    }
    concat::fragment {$catalogs_conf:
        target  => $catalogs_conf,
        order   => '01',
        content => $managed,
    }
}
