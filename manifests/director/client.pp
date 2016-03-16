
define bareos::director::client (
    $daemon_name    = $title,
    $address        = $::fqdn,
    $password,
    $options        = {},
) {
    include director
    
    concat::fragment {"${director::clients_conf}+${daemon_name}":
        target  => $director::clients_conf,
        order   => '05',
        content => template('bareos/director/client.conf.erb'),
    }
}
