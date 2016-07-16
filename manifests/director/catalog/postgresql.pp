
class bareos::director::catalog::postgresql inherits bareos::params {

    include bareos::global
    include bareos::repo
    
    package {$bareos::params::catalog_package['postgresql']:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
    }
}
