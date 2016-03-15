
define bareos::director::console (
    $console_name       = $title,
    $console_password   = $password,
    $options  = {},
) {
	include director
	
	concat::fragment {"${director::consoles_conf}+${console_name}":
		target  => $director::consoles_conf,
		order   => '05',
		content => template('bareos/director/console.conf.erb'),
	}
}
