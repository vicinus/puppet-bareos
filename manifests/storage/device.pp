
define bareos::storage::device (
    $device_name      = $title,
    $media_type,
    $archive_device,
    $label_media      = false,
    $random_access    = true,
    $auto_mount       = true,
    $removeable_media = false,
    $always_open      = false,
) {
	include params
	include storage
	
	concat::fragment {"${storage::devices_conf}+${device_name}":
		target  => $storage::devices_conf,
		order   => '05',
		content => template('bareos/storage/device.conf.erb'),
	}
}
