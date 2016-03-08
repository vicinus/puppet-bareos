
class bareos::filedaemon () inherits bareos::params {

    include repo

    package {$params::package_filedaemon:
        ensure  => installed,
        require => $repo::require,
    }
}
