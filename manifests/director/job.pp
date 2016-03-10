
define bareos::director::job (
    $job_name = $title,
    $job_definition,
    $job_type,
    $level,
    $file_set,
    $storage,
    $schedule,
    $pool,
    $messages,
    $where,
    $priority,
    $run_before_script,
    $run_after_script,
) {
	include params
	include director
	
	concat::fragment {"${director::jobs_conf}+${job_name}":
		target  => $director::jobs_conf,
		order   => '05',
		content => template('bareos/director/job.conf.erb'),
	}
}