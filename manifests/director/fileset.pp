
define bareos::director::fileset (
    $options         = {},
    $includes        = [],
    $include_options = {},
    $excludes        = [],
    $exclude_options = {},
    $conf_includes   = [],
) {
    include director
    
    $fileset_name    = $title
    
    concat::fragment {"${director::filesets_conf}+${fileset_name}":
        target  => $director::filesets_conf,
        order   => "05_${fileset_name}",
        content => template('bareos/director/fileset.conf.erb'),
    }
}
