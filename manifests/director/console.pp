
define bareos::director::console (
    $console_name = $title,
    $password,
    $options      = {},
) {
    include director

    shared::console {"director_${title}":
        console_name => $console_name,
        target       => $director::consoles_conf,
        order        => '05',
        password     => $password,
        options      => $options,
    }
}
