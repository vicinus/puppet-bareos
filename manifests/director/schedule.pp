
define bareos::director::schedule (
    $enabled       = true,
    $runs          = [],
    $options       = {},
    $includes      = [],
) {
    include director
    
    $schedule_name = $title
    
    concat::fragment {"${director::schedules_conf}+${schedule_name}":
        target  => $director::schedules_conf,
        order   => '05',
        content => template('bareos/director/schedule.conf.erb'),
    }
}
