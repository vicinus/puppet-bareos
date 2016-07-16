
class bareos::director::catalog::sqlite3 inherits bareos::params {

    include bareos::global
    include bareos::repo
    
    package {$bareos::params::catalog_package['sqlite3']:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
    }
}
