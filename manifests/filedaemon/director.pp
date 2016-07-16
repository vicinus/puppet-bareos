
define bareos::filedaemon::director (
    $password,
    $director_name = $title,
    $options       = {},
) {

    include bareos::filedaemon

    bareos::shared::director {"filedaemon_${title}":
        director_name => $director_name,
        password      => $password,
        target        => $bareos::filedaemon::conf,
        order         => "05_${title}",
        options       => $options,
    }

}
