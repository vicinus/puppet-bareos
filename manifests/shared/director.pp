
define bareos::shared::director (
    $password,
    $target,
    $director_name = $title,
    $order         = '06',
    $options       = {},
    $includes      = [],
) {
    concat::fragment {"${target}+director_${$director_name}":
        target  => $target,
        order   => "${order}_${$director_name}",
        content => template('bareos/shared/director.conf.erb'),
    }
}
