
define bareos::director::job (
    $job_name = $title,
    $job_type,
    $pool,
    $messages,
    $job_definition = undef,
    $level = undef,
    $file_set = undef,
    $storage = undef,
    $schedule = undef,
    $where = undef,
    $priority = undef,
    $run_before_script = undef,
    $run_after_script = undef,
) {
	include params
	include director
	
	concat::fragment {"${director::jobs_conf}+${job_name}":
		target  => $director::jobs_conf,
		order   => '05',
		content => template('bareos/director/job.conf.erb'),
	}
}