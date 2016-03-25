
class bareos::filedaemon::plugin::bpipe (
    $package_name = $plugin::bpipe_package
) inherits plugin {

    if $package_name == $plugin::bpipe_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
