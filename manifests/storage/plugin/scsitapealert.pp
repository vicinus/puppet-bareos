
class bareos::storage::plugin::scsitapealert (
    $package_name = $plugin::scsitapealert_package
) inherits plugin {

    include repo
    
    if $package_name == $plugin::scsitapealert_package {
        realize Package[$package_name]
    } else {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }

}
