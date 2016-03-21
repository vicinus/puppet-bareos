
define bareos::shared::director (
    $director_name = $title,
    $password,
    $target,
    $order         = '06',
    $options       = {},
    $includes      = [],
) {
    concat::fragment {"${target}+director_${$director_name}":
        target  => $target,
        order   => $order,
        content => template('bareos/shared/director.conf.erb'),
    }
}
