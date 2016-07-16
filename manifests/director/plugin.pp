
class bareos::director::plugin (
    $python_package = 'bareos-director-python-plugin',
) {

    include bareos::global
    include bareos::repo

    @package {$python_package:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
    }

}
