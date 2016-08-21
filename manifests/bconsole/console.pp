
define bareos::bconsole::console (
    $password,
    $console_name = $title,
    $director     = undef,
    $options      = {},
) {
    include bareos::bconsole

    concat::fragment {"${bareos::bconsole::conf}+console_${console_name}":
        target  => $bareos::bconsole::conf,
        order   => "10_${console_name}",
        content => template('bareos/bconsole/console.conf.erb'),
    }
}
