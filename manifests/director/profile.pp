
define bareos::director::profile (
    $acls         = {},
    $options      = {},
    $includes     = [],
) {
    include bareos::director
    
    $profile_name = $title
    
    concat::fragment {"${bareos::director::profile_conf}+${profile_name}":
        target  => $bareos::director::profile_conf,
        order   => "05_${profile_name}",
        content => template('bareos/director/profile.conf.erb'),
    }
}
