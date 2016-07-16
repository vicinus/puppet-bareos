
class bareos::filedaemon::plugin::python (
    $package_name = $bareos::filedaemon::plugin::python_package
) inherits bareos::filedaemon::plugin {

    if $package_name == $bareos::filedaemon::plugin::python_package {
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
