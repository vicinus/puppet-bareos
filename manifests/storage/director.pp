
define bareos::storage::director (
    $director_name = $title,
    $password,
    $options       = {},
) {

    include storage

    shared::director {"storage_${title}":
        director_name => $director_name,
        password      => $password,
        target        => $storage::conf,
        order         => "05_${title}",
        options       => $options,
    }

}
