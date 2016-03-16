
class bareos::catalog::postgresql inherits params {
    include repo
    
    package {$params::catalog_package['postgresql']:
        ensure  => installed,
        require => $repo::require,
    }
}
