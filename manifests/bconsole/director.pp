
define bareos::bconsole::director (
    $director_name      = $title,
    $password           = $params::dummy_password,
    $address            = undef,
    $port               = $params::director_port,
    $heartbeat_interval = undef,
    $description        = undef,
    $options            = {},
) {

    include params
    include bconsole
    
    concat::fragment {"${bconsole::conf}+director_${director_name}":
        target  => $bconsole::conf,
        order   => '05',
        content => template('bareos/bconsole/director.conf.erb'),
    }

}
