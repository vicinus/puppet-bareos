
define bareos::shared::console (
    $console_name = $title,
    $target,
    $order        = '06',
    $password,
    $options      = {},
) {
    concat::fragment {"${target}+${console_name}":
        target  => $target,
        order   => $order,
        content => template('bareos/shared/console.conf.erb'),
    }
}
