
define bareos::director::messages (
    $options       = {},
    $includes      = [],
) {
    include director
    
    $messages_name = $title
    
    shared::messages {"director_${title}":
        messages_name => $messages_name,
        target        => $director::messages_conf,
        options       => $options,
        includes      => $includes,
    }
}
