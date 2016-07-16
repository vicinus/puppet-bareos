
define bareos::storage::device (
    $media_type,
    $archive_device,
    $label_media      = false,
    $random_access    = true,
    $auto_mount       = true,
    $removeable_media = false,
    $always_open      = false,
) {
    include bareos::params
    include bareos::storage
    
    $device_name = $title
    
    concat::fragment {"${bareos::storage::devices_conf}+${device_name}":
        target  => $bareos::storage::devices_conf,
        order   => "05_${device_name}",
        content => template('bareos/storage/device.conf.erb'),
    }
}
