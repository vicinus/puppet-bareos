
class bareos::filedaemon::plugin::ceph (
    $package_name = $plugin::ceph_package
) inherits plugin {

    if $package_name == $plugin::ceph_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
