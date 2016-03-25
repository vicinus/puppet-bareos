
class bareos::storage::plugin::autoxflate (
    $package_name = $plugin::autoxflate_package
) inherits plugin {
    
    if $package_name != $plugin::autoxflate_package {

        include global
        include repo

        package {$package_name:
            ensure  => $global::package_ensure,
            require => $repo::require,
        }
    }
    
    # plugin is bundled with default distribution

}
