
define bareos::filedaemon::director (
    $director_name = $title,
    $password,
    $options       = {},
) {

    include filedaemon

    shared::director {"filedaemon_${title}":
        director_name => $director_name,
        password      => $password,
        target        => $filedaemon::conf,
        order         => "05_${title}",
        options       => $options,
    }

}
