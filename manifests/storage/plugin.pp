
class bareos::storage::plugin (
    $python_package        = 'bareos-storage-python-plugin',
    $scsicrypto_package    = 'bareos-storage-tape',
    $scsitapealert_package = 'bareos-storage-tape',
    $autoxflate_package    = $bareos::storage::package_name,
) {

    include bareos::global
    include bareos::repo
    include bareos::storage
    
    @package {$python_package:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
    }
    
    @package {$scsicrypto_package:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
    }

}
