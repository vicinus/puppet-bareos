
class bareos::storage::plugin::python (
    $package_name = $plugin::python_package
) inherits plugin {

    include repo
    
    if $package_name == $plugin::python_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
