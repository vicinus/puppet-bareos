
define bareos::messages (
    $messages_name = $title,
    $target,
    $order         = '06',
    $options       = {}, # TODO resource references (client, storage, ...) as explicit parameters with validation/require?
) {
    concat::fragment {"${target}+messages+${messages_name}":
        target  => $target,
        order   => $order,
        content => template('bareos/messages.conf.erb'),
    }
}
