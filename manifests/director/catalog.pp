
define bareos::director::catalog (
    $catalog_name         = $title,
    $db_driver,
    $db_name,
    $db_address           = undef,
    $db_port              = undef,
    $db_socket            = undef,
    $db_password          = undef,
    $db_user              = undef,
    $description          = undef,
    $no_batch_insert      = undef,
    $exit_on_fatal        = undef,
    $idle_timeout         = undef,
    $inc_connections      = undef,
    $max_connections      = undef,
    $min_connections      = undef,
    $multiple_connections = undef,
    $reconnect            = undef,
    $validate_timeout     = undef,
) {
	include params
	include director
	
	if $db_driver == 'sqlite3' {
        include catalog::sqlite3
	
	    exec {"${db_driver}_create_db_for_${db_name}":
	        command => '/usr/lib/bareos/scripts/create_bareos_database',
	        creates => "${params::datadir}/${db_name}.db",
	        notify  => Exec["${db_driver}_create_tables_for_${db_name}"],
	    }
	
	    ->
	
	    exec {"${db_driver}_create_tables_for_${db_name}":
	        command     => '/usr/lib/bareos/scripts/make_bareos_tables',
	        refreshonly => true,
	        notify      => Exec["${db_driver}_grant_for_${db_name}"],
	    }
	
	    ->
	
	    exec {"${db_driver}_grant_for_${db_name}":
	        command     => '/usr/lib/bareos/scripts/grant_bareos_privileges',
	        refreshonly => true,
	    }
	
	} elsif $db_driver == 'mysql' {
        include catalog::mysql
        
        if $db_address {
            $host_param = "-h '${db_address}'"
        }
        if $db_user {
            $user_param = "'-u${db_user}'"
        }
        if $db_password {
            $pass_param = "-p '${db_password}'"
        }
	
	    exec {"${db_driver}_create_tables_for_${db_name}":
	        command     => "/usr/lib/bareos/scripts/make_bareos_tables ${host_param} ${user_param} ${pass_param}",
	        refreshonly => true,
	    }
	
	} elsif $db_driver == 'postgresql' {
        include catalog::postgresql
	    notify {"database ${db_name} cannot be created automatically in ${db_driver}!":}
	} else {
	    fail('Unsupported database driver!')
	}
	
	concat::fragment {"${director::catalogs_conf}+${catalog_name}":
		target  => $director::catalogs_conf,
		order   => '05',
		content => template('bareos/director/catalog.conf.erb'),
	}

}
