
define bareos::director::profile (
    $profile_name       = $title,
    $options  = {},
) {
	include director
	
	concat::fragment {"${director::profile_conf}+${profile_name}":
		target  => $director::profile_conf,
		order   => '05',
		content => template('bareos/director/profile.conf.erb'),
	}
}
