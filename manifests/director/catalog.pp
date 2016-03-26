
define bareos::director::catalog (
    $db_driver,
    $db_name,
    $db_address   = undef,
    $db_port      = undef,
    $db_socket    = undef,
    $db_user      = undef,
    $db_password  = undef,
    $options      = {},
    $data_dir     = $params::datadir,
    $scripts_dir  = $params::scripts_dir,
    $includes     = [],
) {
    include params
    include director
    
    $catalog_name = $title
    
    $fragment = "${director::catalogs_conf}+${catalog_name}"
    $cmd_require = [
        Package[$director::package_name],
        Concat[$director::catalogs_conf],
    ]
    
    $prefix        = "${catalog_name}_with_${db_driver}_for_${db_name}_do_"
    $create_db     = "${prefix}create_db"
    $create_tables = "${prefix}create_tables"
    $grant_perms   = "${prefix}grant"
    
    if $db_driver == 'sqlite3' {
        include catalog::sqlite3
    
        exec {$create_db:
            command   => "'${scripts_dir}/create_bareos_database' sqlite3",
            creates   => "${data_dir}/${db_name}.db",
            notify    => Exec[$create_tables],
            require   => $cmd_require,
            subscribe => Concat::Fragment[$fragment],
        }
    
        ->
    
        exec {$create_tables:
            command     => "'${scripts_dir}/make_bareos_tables' sqlite3",
            refreshonly => true,
            notify      => Exec[$grant_perms],
        }
    
        ->
    
        exec {$grant_perms:
            command     => "'${scripts_dir}/grant_bareos_privileges' sqlite3",
            refreshonly => true,
            notify      => Service[$director::service_name],
        }
    
    } elsif $db_driver == 'mysql' {
        include catalog::mysql
        
        if $db_address {
            $host_param =  "'--host=${db_address}'"
        }
        if $db_port {
            $port_param = "'--port=${db_port}'"
        }
        if $db_user {
            $user_param = "'--user=${db_user}'"
        }
        if $db_password {
            $pass_param = "'--password=${db_password}'"
        }
        if $db_socket {
            $socket_param = "'--socket=${db_socket}'"
        }
    
        exec {$create_tables:
            command     => "'${scripts_dir}/make_bareos_tables' mysql ${host_param} ${port_param} ${user_param} ${pass_param} ${socket_param}",
            refreshonly => true,
            require     => $cmd_require,
            subscribe   => Concat::Fragment[$fragment],
            notify      => Service[$director::service_name],
        }
    
    } elsif $db_driver == 'postgresql' {
        include catalog::postgresql
        notify {"database ${db_name} cannot be created automatically in ${db_driver}!":}
    } else {
        fail('Unsupported database driver! Open a Pull Request on Github if you need this!')
    }
    
    $conf = $director::catalogs_conf
    concat::fragment {$fragment:
        target  => $conf,
        order   => '05',
        content => template('bareos/director/catalog.conf.erb'),
    }

}
