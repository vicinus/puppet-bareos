
define bareos::director::pool (
    $type,
    $catalog  = undef,
    $storage  = undef,
    $options  = {},
    $includes = [],
) {
    include director
    
    $pool_name = $title
    
    if $catalog {
        realize Catalog[$catalog]
    }
    
    if $storage {
        realize Storage[$storage]
    }
    
    concat::fragment {"${director::pools_conf}+${pool_name}":
        target  => $director::pools_conf,
        order   => '05',
        content => template('bareos/director/pool.conf.erb'),
    }
}
