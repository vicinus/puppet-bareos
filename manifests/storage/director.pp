
define bareos::storage::director (
    $password,
    $director_name = $title,
    $options       = {},
) {

    include bareos::storage

    bareos::shared::director {"storage_${title}":
        director_name => $director_name,
        password      => $password,
        target        => $bareos::storage::conf,
        order         => "05_${title}",
        options       => $options,
    }

}
