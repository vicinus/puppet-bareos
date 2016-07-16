
define bareos::director::storage (
    $address,
    $password,
    $device, # No dependency on the device as the device definition might be on a different node
    $media_type,
    $options      = {},
    $includes     = [],
) {
    include bareos::director
    
    $storage_name = $title
    
    concat::fragment {"${bareos::director::storages_conf}+${storage_name}":
        target  => $bareos::director::storages_conf,
        order   => "05_${storage_name}",
        content => template('bareos/director/storage.conf.erb'),
    }
}
