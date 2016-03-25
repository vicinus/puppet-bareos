
class bareos::filedaemon::plugin::vmware (
    $package_name = $plugin::vmware_package
) inherits plugin {

    if $package_name == $plugin::vmware_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
