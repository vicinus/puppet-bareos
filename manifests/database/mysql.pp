
class bareos::database::mysql extends bareos::params {

    package {$::bareos::params::package_db_mysql:
        ensure => installed,
    }

}
