
define bareos::director::jobdefs (
    $jobdef_name = $title,
    $options  = {},
) {
	include director
	
	concat::fragment {"${director::jobdefs_conf}+${jobdef_name}":
		target  => $director::jobdefs_conf,
		order   => '05',
		content => template('bareos/director/jobdefs.conf.erb'),
	}
}
