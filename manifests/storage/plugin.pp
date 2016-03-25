
class bareos::storage::plugin (
    $python_package        = 'bareos-storage-python-plugin',
    $scsicrypto_package    = 'bareos-storage-tape',
    $scsitapealert_package = 'bareos-storage-tape',
    $autoxflate_package    = $storage::package_name,
) {

    include repo
    include storage
    
    @package {$python_package:
        ensure  => installed,
        require => $repo::require,
    }
    
    @package {$scsicrypto_package:
        ensure  => installed,
        require => $repo::require,
    }

}
