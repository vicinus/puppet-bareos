
class bareos::storage::plugin::scsicrypto (
    $package_name = $plugin::scsicrypto_package
) inherits plugin {

    include repo
    
    if $package_name == $plugin::scsicrypto_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
