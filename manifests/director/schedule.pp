
define bareos::director::schedule (
    $schedule_name = $title,
    $runs          = [],
    $options       = {},
    $includes      = [],
) {
    include director
    
    concat::fragment {"${director::schedules_conf}+${schedule_name}":
        target  => $director::schedules_conf,
        order   => '05',
        content => template('bareos/director/schedule.conf.erb'),
    }
}
