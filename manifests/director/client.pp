
define bareos::director::client (
    $enabled  = true,  
    $address  = $::fqdn,
    $password,
    $catalog  = undef,
    $options  = {},
    $includes = [],
) {
    include director
    
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
