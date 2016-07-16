
class bareos::filedaemon::plugin::bpipe (
    $package_name = $bareos::filedaemon::plugin::bpipe_package
) inherits bareos::filedaemon::plugin {

    if $package_name == $bareos::filedaemon::plugin::bpipe_package {
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
