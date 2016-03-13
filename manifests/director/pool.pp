
define bareos::director::pool (
    $pool_name = $title,
    $type,
    $options   = {},
) {
	include director
	
	concat::fragment {"${director::pools_conf}+${pool_name}":
		target  => $director::pools_conf,
		order   => '05',
		content => template('bareos/director/pool.conf.erb'),
	}
}
