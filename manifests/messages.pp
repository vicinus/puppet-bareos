
define bareos::messages (
    $target,
    $messages_name = $title,
    $options       = {}, # TODO resource references (client, storage, ...) as explicit parameters with validation/require?
) {
    concat::fragment {"${target}+messages+${messages_name}":
        target  => $target,
        order   => '06',
        content => template('bareos/messages.conf.erb'),
    }
}
