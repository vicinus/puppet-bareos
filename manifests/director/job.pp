
define bareos::director::job (
    $job_name = $title,
    $options  = {}, # TODO resource references (client, storage, ...) as explicit parameters with validation/require?
) {
    include director
    
    concat::fragment {"${director::jobs_conf}+${job_name}":
        target  => $director::jobs_conf,
        order   => '05',
        content => template('bareos/director/job.conf.erb'),
    }
}
