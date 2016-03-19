
define bareos::storage::messages (
    $messages_name = $title,
    $options       = {},
) {
    include storage
    
    bareos::messages {"storage_${title}":
        messages_name => $messages_name,
        target        => $storage::conf,
        order         => '10',
        options       => $options,
    }
}
