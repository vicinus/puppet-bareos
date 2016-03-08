
class bareos::storage inherits params {

    include repo
    
    package {$params::package_storage:
        ensure  => installed,
        require => $repo::require,
    }

}
