
class bareos::bconsole inherits params {

    include repo
    
    package {$params::package_bconsole:
        ensure  => installed,
        require => $repo::require,
    }

}
