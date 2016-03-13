
define bareos::director::messages (
    $messages_name = $title,
    $options       = {}, # TODO resource references (client, storage, ...) as explicit parameters with validation/require?
) {
    include director
    
    bareos::messages {"director_${title}":
        target        => $director::messages_conf,
        messages_name => $messages_name,
        options       => $options,
    }
}
