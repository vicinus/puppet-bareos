
class bareos::catalog::sqlite3 inherits params {
    include repo
    
    package {$params::catalog_package['sqlite3']:
        ensure  => installed,
        require => $repo::require,
    }
}
