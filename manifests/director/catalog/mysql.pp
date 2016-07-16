
class bareos::director::catalog::mysql inherits bareos::params {

    include bareos::global
    include bareos::repo
    
    package {$bareos::params::catalog_package['mysql']:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
    }

}
