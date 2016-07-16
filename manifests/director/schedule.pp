
define bareos::director::schedule (
    $enabled       = true,
    $runs          = [],
    $options       = {},
    $includes      = [],
) {
    include bareos::director
    
    $schedule_name = $title
    
    concat::fragment {"${bareos::director::schedules_conf}+${schedule_name}":
        target  => $bareos::director::schedules_conf,
        order   => "05_${schedule_name}",
        content => template('bareos/director/schedule.conf.erb'),
    }
}
