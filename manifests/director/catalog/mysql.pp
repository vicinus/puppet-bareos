
class bareos::catalog::mysql inherits params {

    include global
    include repo
    
    package {$params::catalog_package['mysql']:
        ensure  => $global::package_ensure,
        require => $repo::require,
    }

}
