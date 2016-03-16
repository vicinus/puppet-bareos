
define bareos::director::fileset (
    $fileset_name    = $title,
    $options         = {},
    $includes        = [],
    $include_options = {},
    $excludes        = [],
    $exclude_options = {},
) {
    include director
    
    concat::fragment {"${director::filesets_conf}+${fileset_name}":
        target  => $director::filesets_conf,
        order   => '05',
        content => template('bareos/director/fileset.conf.erb'),
    }
}
