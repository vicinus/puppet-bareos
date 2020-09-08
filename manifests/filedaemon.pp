
class bareos::filedaemon (
    $daemon_name       = "${::hostname}-fd",
    $port              = $bareos::params::filedaemon_port,
    $director_name,
    $director_password,
    $compatible        = false,
    $default_messages  = true,
    $options           = {},
    $plugins_dir       = $bareos::params::plugins_dir,
    $plugins           = [],
    $user              = $bareos::params::user,
    $group             = $bareos::params::group,
    $conf              = $bareos::params::filedaemon_conf,
    $package_name      = $bareos::params::filedaemon_package,
    $service_name      = $bareos::params::filedaemon_service,
    $service_provider  = undef,
    $pki_signatures    = false,
    $pki_encryption    = false,
    $pki_keypair       = "/etc/bareos/${fqdn}.pem",
    $pki_master_key    = "/etc/bareos/master.cert",
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
        provider => $service_provider,
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
    
    bareos::filedaemon::director {$director_name:
        password => $director_password,
        options => $options,
    }
    
    if $default_messages {
        bareos::filedaemon::messages {'Standard':
            options => {
                'Director' => "${director_name} = all, !skipped, !restored",
            },
        }
    }
}
