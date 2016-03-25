
class bareos::director::plugin (
    $python_package = 'bareos-director-python-plugin',
) {

    include global
    include repo
    include director

    @package {$python_package:
        ensure  => $global::package_ensure,
        require => $repo::require,
    }

}
