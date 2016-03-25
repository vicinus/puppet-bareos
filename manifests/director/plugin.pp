
class bareos::director::plugin (
    $python_package = 'bareos-director-python-plugin',
) {

    include repo
    include director

    @package {$python_package:
        ensure  => installed,
        require => $repo::require,
    }

}
