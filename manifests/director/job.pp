
define bareos::director::job (
    $type       = undef,
    $enabled    = true,
    $is_default = false,
    $base       = undef,
    $fileset    = undef,
    $schedule   = undef,
    $pool       = undef,
    $messages   = undef,
    $storage    = undef,
    $client     = undef,
    $options    = {},
    $includes   = [],
) {
    include director

    $job_name   = $title
    
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
    
    if $base {
        realize Job[$base]
    }
    
    if $fileset {
        realize Fileset[$fileset]
    }
    
    if $schedule {
        realize Director::Schedule[$schedule]
    }
    
    if $pool {
        realize Pool[$pool]
    }
    
    if $messages {
        realize Messages[$messages]
    }
    
    if $storage {
        realize Storage[$storage]
    }
    
    if $client {
        realize Client[$client]
    }
    
    if $is_default {
        $order = '05'
    } else {
        $order = '06'
    }
    
    concat::fragment {"${director::jobs_conf}+${job_name}":
        target  => $director::jobs_conf,
        order   => "${order}_${job_name}",
        content => template('bareos/director/job.conf.erb'),
    }
}
