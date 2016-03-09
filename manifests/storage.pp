
class bareos::storage (
    $storage_name       = "${::hostname}-sd",
    $director_name,
    $director_password,
    $monitor_name       = undef,
    $monitor_password   = undef,
    $max_conc_jobs      = 20,
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
    
    concat {$params::storage_conf:
        ensure  => present,
        owner   => $params::user,
        group   => $params::group,
        mode    => '0640',
        require => Package[$package_name],
        notify  => Service[$service_name],
    }
    
    concat::fragment {$params::storage_conf:
        target  => $params::storage_conf,
        order   => '01',
        content => template('bareos/bareos-sd.conf.erb'),
    }
    
    
    
    file {$params::storage_conf_d:
        ensure  => directory,
        owner   => $params::user,
        group   => $params::group,
        mode    => '0755',
        require => Package[$package_name],
    }

    $devices_conf = "${params::storage_conf_d}/devices.conf"
    concat::fragment {"${params::storage_conf}+${devices_conf}":
        target  => $params::storage_conf,
        order   => '10',
        content => "@${devices_conf}\n",
    }
    concat {$devices_conf:
        ensure  => present,
        owner   => $params::user,
        group   => $params::group,
        mode    => '0640',
        notify  => Service[$service_name],
        require => File[$params::storage_conf_d],
    }
    concat::fragment {$devices_conf:
        target  => $devices_conf,
        order   => '01',
        content => "# Managed by puppet!\n",
    }

}
