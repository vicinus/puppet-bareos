
define bareos::director::pool (
    $type,
    $catalog  = undef,
    $storage  = undef,
    $options  = {},
    $includes = [],
) {
    include bareos::director
    
    $pool_name = $title
    
    if $catalog {
        realize Bareos::Director::Catalog[$catalog]
    }
    
    if $storage {
        realize Bareos::Director::Storage[$storage]
    }
    
    concat::fragment {"${bareos::director::pools_conf}+${pool_name}":
        target  => $bareos::director::pools_conf,
        order   => "05_${pool_name}",
        content => template('bareos/director/pool.conf.erb'),
    }
}
