
define bareos::director::profile (
    $acls         = {},
    $options      = {},
    $includes     = [],
) {
    include director
    
    $profile_name = $title
    
    concat::fragment {"${director::profile_conf}+${profile_name}":
        target  => $director::profile_conf,
        order   => "05_${profile_name}",
        content => template('bareos/director/profile.conf.erb'),
    }
}
