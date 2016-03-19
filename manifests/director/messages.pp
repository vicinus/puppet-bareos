
define bareos::director::messages (
    $messages_name = $title,
    $options       = {}, # TODO resource references (client, storage, ...) as explicit parameters with validation/require?
) {
    include director
    
    bareos::messages {"director_${title}":
        messages_name => $messages_name,
        target        => $director::messages_conf,
        options       => $options,
    }
}
