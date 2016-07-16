
class bareos::filedaemon::plugin::rados (
    $package_name = $bareos::filedaemon::plugin::rados_package
) inherits bareos::filedaemon::plugin {

    if $package_name == $bareos::filedaemon::plugin::rados_package {
        realize Package[$package_name]
    } else {

        include bareos::global
        include bareos::repo
    
        package {$package_name:
            ensure  => $bareos::global::package_ensure,
            require => $bareos::repo::require,
        }
    }

}
