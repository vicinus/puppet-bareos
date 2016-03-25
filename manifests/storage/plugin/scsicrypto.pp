
class bareos::storage::plugin::scsicrypto (
    $package_name = $plugin::scsicrypto_package
) inherits plugin {
    
    if $package_name == $plugin::scsicrypto_package {
        realize Package[$package_name]
    } else {

        include global
        include repo

        package {$package_name:
            ensure  => $global::package_ensure,
            require => $repo::require,
        }
    }

}
