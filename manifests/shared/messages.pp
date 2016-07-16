
define bareos::shared::messages (
    $target,
    $messages_name = $title,
    $order         = '06',
    $options       = {},
    $includes      = [],
) {
    concat::fragment {"${target}+messages_${messages_name}":
        target  => $target,
        order   => "${order}_${messages_name}",
        content => template('bareos/shared/messages.conf.erb'),
    }
}
