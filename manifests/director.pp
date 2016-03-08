
class bareos::director (
    $director_name      = "${::hostname}-dir",
    $director_password, # console (main?) password
    $monitor_name       = undef,
    $monitor_password   = undef, # console (main?) password
    $daemon_name        = "${::hostname}-fd",
) inherits params {

    include repo
    
    package {$params::package_director:
        ensure  => installed,
        require => $repo::require,
    }
    
    
    class {'filedaemon':
        director_name     => $director_name,
        director_password => '7NejtxyZnHIXfoNNjs1HrLWjL55JaG+D0fZGHt1+Lcom', # TODO password
        daemon_name       => $daemon_name,
    }

}
