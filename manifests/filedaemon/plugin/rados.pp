
class bareos::filedaemon::plugin::rados (
    $package_name = $plugin::rados_package
) inherits plugin {

    if $package_name == $plugin::rados_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
