
define bareos::director::job (
    $job_name = $title,
    $defaults = undef,
    $options  = {}, # TODO resource references (client, storage, ...) as explicit parameters with validation/require?
    $includes = [],
) {
    include director
    
    $conf_root = "${director::jobs_conf}.d"
    $conf_d = "${conf_root}/${job_name}"
    
    file {"${conf_d}":
        ensure  => directory,
        owner   => $director::user,
        group   => $director::group,
        mode    => '0755',
        purge   => true,
        recurse => true,
        require => File[$conf_root],
    }
    
    if $defaults {
        $defaults_req = Jobdefs[$defaults]
    }
    
    concat::fragment {"${director::jobs_conf}+${job_name}":
        target  => $director::jobs_conf,
        order   => '05',
        content => template('bareos/director/job.conf.erb'),
        require => $defaults_req,
    }
}
