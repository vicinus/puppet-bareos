
class bareos::catalog::sqlite3 inherits params {

    include global
    include repo
    
    package {$params::catalog_package['sqlite3']:
        ensure  => $global::package_ensure,
        require => $repo::require,
    }
}
