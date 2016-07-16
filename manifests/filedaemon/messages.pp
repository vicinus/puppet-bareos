
define bareos::filedaemon::messages (
    $messages_name = $title,
    $options       = {},
) {
    include bareos::filedaemon
    
    bareos::shared::messages {"filedaemon_${title}":
        messages_name => $messages_name,
        target        => $bareos::filedaemon::conf,
        order         => '10',
        options       => $options,
    }
}
