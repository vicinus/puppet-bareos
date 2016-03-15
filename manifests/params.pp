
class bareos::params {

    $user        = 'bareos'
    $group       = 'bareos'
    $confdir     = '/etc/bareos'
    $libdir      = '/usr/lib/bareos'
    $datadir     = '/var/lib/bareos'
    $plugins_dir = "${libdir}/plugins"
    
    $filedaemon_package = 'bareos-filedaemon'
    $filedaemon_service = 'bareos-filedaemon'
    $filedaemon_conf    = "${confdir}/bareos-fd.conf"

    $director_package     = 'bareos-director'
    $director_service     = 'bareos-director'
    $director_conf        = "${confdir}/bareos-dir.conf"
    $director_conf_d      = "${confdir}/bareos-dir.d"
    $director_backend_dir = "${libdir}s/backends"
    
    $storage_package = 'bareos-storage'
    $storage_service = 'bareos-storage'
    $storage_conf    = "${confdir}/bareos-sd.conf"
    $storage_conf_d  = "${confdir}/bareos-sd.d"
    
    $bconsole_package = 'bareos-bconsole'
    $bconsole_conf    = "${confdir}/bconsole.conf"
    
    $webui_package = 'bareos-webui'

    $catalog_package = {
        'mysql'      => 'bareos-database-mysql',
        'postgresql' => 'bareos-database-postgresql',
        'sqlite3'    => 'bareos-database-sqlite3',
    }
}
