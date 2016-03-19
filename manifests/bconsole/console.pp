
define bareos::bconsole::console (
    $console_name = $title,
    $password,
    $director     = undef,
) {
    include bconsole

    $options = {}

    if $director {
        $options['Director'] = $director
    }

    shared::console {"bconsole_${title}":
        console_name => $console_name,
        target       => $bconsole::conf,
        order        => '10',
        password     => $password,
        options      => $options,
    }
}
