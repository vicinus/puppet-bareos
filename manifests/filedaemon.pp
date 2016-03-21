
class bareos::filedaemon (
    $daemon_name       = "${::hostname}-fd",
    $director_name,
    $director_password,
    $max_conc_jobs     = 20,
    $default_messages  = true,
    $user              = $params::user,
    $group             = $params::group,
    $conf              = $params::filedaemon_conf,
    $package_name      = $params::filedaemon_package,
    $service_name      = $params::filedaemon_service,
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
        content => template('bareos/bareos-fd.conf.erb'),
    }
    
    filedaemon::director {$director_name:
        password => $director_password,
    }
    
    if $default_messages {
        filedaemon::messages {'Standard':
            options       => {
                'Director' => "${director_name} = all, !skipped, !restored",
            },
        }
    }
}
