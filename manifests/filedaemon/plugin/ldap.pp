
class bareos::filedaemon::plugin::ldap (
    $package_name = $plugin::ldap_package
) inherits plugin {

    if $package_name == $plugin::ldap_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
