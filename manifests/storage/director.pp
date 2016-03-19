
define bareos::storage::director (
    $director_name = $title,
    $password,
    $options       = {},
) {

    include storage

    director::reference {"storage_${title}":
        director_name => $director_name,
        password      => $password,
        target        => $storage::conf,
        order         => '05',
        options       => $options,
    }

}
