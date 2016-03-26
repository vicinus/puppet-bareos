
define bareos::shared::messages (
    $messages_name = $title,
    $target,
    $order         = '06',
    $options       = {},
    $includes      = [],
) {
    concat::fragment {"${target}+messages+${messages_name}":
        target  => $target,
        order   => $order,
        content => template('bareos/shared/messages.conf.erb'),
    }
}
