
class bareos::director () inherits params {

    include repo
    
    package {$params::package_director:
        ensure  => installed,
        require => $repo::require,
    }
    
    
    class {'filedaemon':
        # TODO director specifics
    }

}
