
define bareos::director::reference (
    $director_name = $title,
    $password,
    $target,
    $order         = '06',
    $options       = {},
) {
    concat::fragment {"${target}+director_${$director_name}":
        target  => $target,
        order   => $order,
        content => template('bareos/director/reference.conf.erb'),
    }
}
