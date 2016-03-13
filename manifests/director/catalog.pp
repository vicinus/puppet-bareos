
define bareos::director::catalog (
    $catalog_name         = $title,
    $db_driver,
    $db_name,
    $options              = {},
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
        
        if $options['DB Address'] {
            $host_param = "-h '" + $options['DB Address'] + "'"
        }
        if $options['DB User'] {
            $user_param = "'-u" + $options['DB User'] + "'"
        }
        if $options['DB Password'] {
            $pass_param = "-p '" + $options['DB Password'] + "'"
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
