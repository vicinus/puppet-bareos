
define bareos::bconsole::console (
    $console_name = $title,
    $password,
    $director     = undef,
    $options      = {},
) {
    include bconsole

    concat::fragment {"${bconsole::conf}+console_${console_name}":
        target  => $bconsole::conf,
        order   => "10_${console_name}",
        content => template('bareos/bconsole/console.conf.erb'),
    }
}
