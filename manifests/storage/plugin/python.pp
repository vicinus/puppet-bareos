
class bareos::storage::plugin::python (
    $package_name = $plugin::python_package
) inherits plugin {

    include repo
    
    package {$package_name:
        ensure  => installed,
        require => $repo::require,
    }

}
