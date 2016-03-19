
class bareos::client (
    $director_name,
    $access_password,
    $monitor_name       = undef,
    $monitor_password   = undef, # console (main?) password
    $daemon_name        = "${::hostname}-fd",
) inherits bareos::params {

    include repo
    
    class {'filedaemon':
        director_name     => $director_name,
        director_password => $access_password,
        daemon_name       => $daemon_name,
    }
}
