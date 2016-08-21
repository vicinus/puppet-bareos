
define bareos::director::job (
    $type       = undef,
    $enabled    = true,
    $is_default = false,
    $base       = undef,
    $fileset    = undef,
    $scheduled  = undef,
    $pool       = undef,
    $messages   = undef,
    $storage    = undef,
    $client     = undef,
    $options    = {},
    $includes   = [],
) {
    include bareos::director

    $job_name   = $title
    
    $conf_root = "${bareos::director::jobs_conf}.d"
    $conf_d = "${conf_root}/${job_name}"
    
    file {$conf_d:
        ensure  => directory,
        owner   => $bareos::director::user,
        group   => $bareos::director::group,
        mode    => '0755',
        purge   => true,
        recurse => true,
        require => File[$conf_root],
    }
    
    if $base {
        realize Bareos::Director::Job[$base]
    }
    
    if $fileset {
        realize Bareos::Director::Fileset[$fileset]
    }
    
    if $scheduled {
        realize Bareos::Director::Schedule[$scheduled]
    }
    
    if $pool {
        realize Bareos::Director::Pool[$pool]
    }
    
    if $messages {
        realize Bareos::Director::Messages[$messages]
    }
    
    if $storage {
        realize Bareos::Director::Storage[$storage]
    }
    
    if $client {
        realize Bareos::Director::Client[$client]
    }
    
    if $is_default {
        $order = '05'
    } else {
        $order = '06'
    }
    
    concat::fragment {"${bareos::director::jobs_conf}+${job_name}":
        target  => $bareos::director::jobs_conf,
        order   => "${order}_${job_name}",
        content => template('bareos/director/job.conf.erb'),
    }
}
