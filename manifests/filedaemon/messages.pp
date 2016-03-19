
define bareos::filedaemon::messages (
    $messages_name = $title,
    $options       = {},
) {
    include filedaemon
    
    shared::messages {"filedaemon_${title}":
        messages_name => $messages_name,
        target        => $filedaemon::conf,
        order         => '10',
        options       => $options,
    }
}
