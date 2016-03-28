
define bareos::director::client (
    $enabled  = true,  
    $address  = $::fqdn,
    $port     = $params::filedaemon_port,
    $password,
    $catalog  = undef,
    $options  = {},
    $includes = [],
) {
    include director
    include params
    
    $daemon_name = $title
    
    if $catalog {
        realize Catalog[$catalog]
    }
    
    concat::fragment {"${director::clients_conf}+${daemon_name}":
        target  => $director::clients_conf,
        order   => '05',
        content => template('bareos/director/client.conf.erb'),
    }
}
