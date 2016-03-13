
class bareos::filedaemon (
    $director_name,     # name of the director connecting to the filedaemon
    $director_password, # password required by the director connecting ("master needs to know my password")
    $monitor_name      = undef,
    $monitor_password  = undef,
    $daemon_name       = "${::hostname}-fd",
    $max_conc_jobs     = 20,
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
    
    messages {'File Daemon Messages':
        messages_name => 'Standard',
        target        => $conf,
        options       => {
            'Director' => "${director_name} = all, !skipped, !restored",
        },
    }
}
