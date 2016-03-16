
class bareos::catalog::mysql inherits params {
    include repo
    
    package {$params::catalog_package['mysql']:
        ensure  => installed,
        require => $repo::require,
    }

}
