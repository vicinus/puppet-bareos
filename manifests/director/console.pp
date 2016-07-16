
define bareos::director::console (
    $password,
    $console_name = $title,
    $profile      = undef,
    $description  = undef,
    $acls         = {},
    $options      = {},
    $includes     = [],
) {
    include bareos::director
    
    if $profile {
        realize Bareos::Director::Profile[$profile]
    }

    concat::fragment {"${bareos::director::consoles_conf}+console_${console_name}":
        target  => $bareos::director::consoles_conf,
        order   => "05_${console_name}",
        content => template('bareos/director/console.conf.erb'),
    }
}
