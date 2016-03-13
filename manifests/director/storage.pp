
define bareos::director::storage (
    $storage_name = $title,
    $address,
    $password,
    $device,
    $media_type,
    $options      = {},
) {
	include director
	
	concat::fragment {"${director::storages_conf}+${storage_name}":
		target  => $director::storages_conf,
		order   => '05',
		content => template('bareos/director/storage.conf.erb'),
	}
}
