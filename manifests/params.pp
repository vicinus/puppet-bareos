
class bareos::params {

    $director_port  = 9101
    $dummy_password = 'NOPE NO PASSWORD HERE! Use password from console block!'

    case $::osfamily {
        'Debian': {
            $user        = 'bareos'
            $group       = 'bareos'
            $confdir     = '/etc/bareos'
            $libdir      = '/usr/lib/bareos'
            $datadir     = '/var/lib/bareos'
            $plugins_dir = "${libdir}/plugins"
            $scripts_dir = "${libdir}/scripts"
            
            $systemd = $::lsbmajdistrelease >= 8
            
            $filedaemon_package = 'bareos-filedaemon'
            $filedaemon_service = 'bareos-fd'
            $filedaemon_systemd = $filedaemon_package
            $filedaemon_conf    = "${confdir}/bareos-fd.conf"

            $director_package     = 'bareos-director'
            $director_service     = 'bareos-dir'
            $director_systemd     = $director_package
            $director_conf        = "${confdir}/bareos-dir.conf"
            $director_conf_d      = "${confdir}/bareos-dir.d"
            $director_backend_dir = "${libdir}/backends"
            $director_query_file  = "${libdir}/scripts/query.sql"
            
            $storage_package = 'bareos-storage'
            $storage_service = 'bareos-sd'
            $storage_systemd = $storage_package
            $storage_conf    = "${confdir}/bareos-sd.conf"
            $storage_conf_d  = "${confdir}/bareos-sd.d"
            
            $bconsole_package = 'bareos-bconsole'
            $bconsole_conf    = "${confdir}/bconsole.conf"
            
            $webui_package        = 'bareos-webui'
            $webui_profile_name   = 'webui'
            $webui_conf_d         = '/etc/bareos-webui'
            $webui_directors_conf = "${webui_conf_d}/directors.ini"
            $webui_user           = 'root'
            $webui_group          = 'root'
            $webui_data_dir       = '/usr/share/bareos-webui'
            $webui_public_dir     = "${webui_data_dir}/public"

            $catalog_package = {
                'mysql'      => 'bareos-database-mysql',
                'postgresql' => 'bareos-database-postgresql',
                'sqlite3'    => 'bareos-database-sqlite3',
            }
        }
        default: {
            fail("Unsupported OS family: ${::osfamily}")
        }
    }
}
