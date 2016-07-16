
define bareos::storage::messages (
    $messages_name = $title,
    $options       = {},
) {
    include bareos::storage
    
    shared::messages {"storage_${title}":
        messages_name => $messages_name,
        target        => $bareos::storage::conf,
        order         => '10',
        options       => $options,
    }
}
