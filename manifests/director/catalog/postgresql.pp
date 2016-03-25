
class bareos::catalog::postgresql inherits params {

    include global
    include repo
    
    package {$params::catalog_package['postgresql']:
        ensure  => $global::package_ensure,
        require => $repo::require,
    }
}
