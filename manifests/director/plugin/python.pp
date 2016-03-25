
class bareos::director::plugin::python (
    $package_name = $plugin::python_package
) inherits plugin {

    if $package_name == $plugin::python_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
