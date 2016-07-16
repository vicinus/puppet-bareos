
class bareos::storage::plugin::scsitapealert (
    $package_name = $bareos::storage::plugin::scsitapealert_package
) inherits bareos::storage::plugin {
    
    if $package_name == $bareos::storage::plugin::scsitapealert_package {
        realize Package[$package_name]
    } else {

        include bareos::global
        include bareos::repo

        package {$package_name:
            ensure  => $bareos::global::package_ensure,
            require => $bareos::repo::require,
        }
    }

}
