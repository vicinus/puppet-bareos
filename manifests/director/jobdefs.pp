
define bareos::director::jobdefs (
    $jobdefs_name = $title,
    $defaults     = undef,
    $options      = {},
    $includes     = [],
) {
    include director
    
    $conf_root = "${director::jobdefs_conf}.d"
    $conf_d = "${conf_root}/${jobdefs_name}"
    
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
    
    concat::fragment {"${director::jobdefs_conf}+${jobdefs_name}":
        target  => $director::jobdefs_conf,
        order   => '05',
        content => template('bareos/director/jobdefs.conf.erb'),
        require => $defaults_req,
    }
}
