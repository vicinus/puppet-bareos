
class bareos::filedaemon::plugin::glusterfs (
    $package_name = $plugin::glusterfs_package
) inherits plugin {

    if $package_name == $plugin::glusterfs_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
