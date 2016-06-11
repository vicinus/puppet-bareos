
define bareos::director::console (
    $console_name = $title,
    $password,
    $profile      = undef,
    $description  = undef,
    $acls         = {},
    $options      = {},
    $includes     = [],
) {
    include director
    
    if $profile {
        realize Profile[$profile]
    }

    concat::fragment {"${director::consoles_conf}+console_${console_name}":
        target  => $director::consoles_conf,
        order   => "05_${console_name}",
        content => template('bareos/director/console.conf.erb'),
    }
}
