
define bareos::bconsole::director (
    $director_name      = $title,
    $password           = $bareos::params::dummy_password,
    $address            = undef,
    $port               = $bareos::params::director_port,
    $heartbeat_interval = undef,
    $description        = undef,
    $options            = {},
) {

    include bareos::params
    include bareos::bconsole
    
    concat::fragment {"${bareos::bconsole::conf}+director_${director_name}":
        target  => $bareos::bconsole::conf,
        order   => "05_${director_name}",
        content => template('bareos/bconsole/director.conf.erb'),
    }

}
