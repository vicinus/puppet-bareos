
class bareos::storage::plugin::autoxflate (
    $package_name = $plugin::autoxflate_package
) inherits plugin {

    include repo
    
    if $package_name != $plugin::autoxflate_package {
        package {$package_name:
            ensure  => installed,
            require => $repo::require,
        }
    }
    
    # plugin is bundled with default distribution

}
