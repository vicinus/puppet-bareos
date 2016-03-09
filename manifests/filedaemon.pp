
class bareos::filedaemon (
    $director_name,     # name of the director connecting to the filedaemon
    $director_password, # password required by the director connecting ("master needs to know my password")
    $monitor_name      = undef,
    $monitor_password  = undef,
    $daemon_name       = "${::hostname}-fd",
    $max_conc_jobs     = 20,
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
    
    file {$params::filedaemon_conf:
        ensure  => file,
        owner   => $params::user,
        group   => $params::group,
        mode    => '0640',
        content => template('bareos/bareos-fd.conf.erb'),
        require => Package[$package_name],
        notify  => Service[$service_name],
    }
}
