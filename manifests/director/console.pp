
define bareos::director::console (
    $console_name       = $title,
    $console_password   = $password,
    $options  = {},
) {
	include director
	
	concat::fragment {"${director::console_conf}+${console_name}":
		target  => $director::console_conf,
		order   => '05',
		content => template('bareos/director/console.conf.erb'),
	}
}
