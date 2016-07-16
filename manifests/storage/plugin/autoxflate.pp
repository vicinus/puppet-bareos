
class bareos::storage::plugin::autoxflate (
    $package_name = $bareos::storage::plugin::autoxflate_package
) inherits bareos::storage::plugin {
    
    if $package_name != $bareos::storage::plugin::autoxflate_package {

        include bareos::global
        include bareos::repo

        package {$package_name:
            ensure  => $bareos::global::package_ensure,
            require => $bareos::repo::require,
        }
    }
    
    # plugin is bundled with default distribution

}
