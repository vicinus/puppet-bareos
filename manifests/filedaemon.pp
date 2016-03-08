
class bareos::filedaemon (
    $director_name,     # name of the director connecting to the filedaemon
    $director_password, # password required by the director connecting ("master needs to know my password")
    $monitor_name = undef,
    $monitor_password = undef,
    $daemon_name  = "${::hostname}-fd"
) inherits bareos::params {

    include repo

    package {$params::package_filedaemon:
        ensure  => installed,
        require => $repo::require,
    }
    
    ->
    
    file {$params::filedaemon_conf:
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        content => template('bareos/bareos-fd.conf.erb')
    }
}
