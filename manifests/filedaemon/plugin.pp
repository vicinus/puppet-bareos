
class bareos::filedaemon::plugin (
    $python_package    = 'bareos-filedaemon-python-plugin',
    $bpipe_package     = $filedaemon::package_name,
    $ldap_package      = 'bareos-filedaemon-ldap-python-plugin',
    $ceph_package      = 'bareos-filedaemon-ceph-plugin',
    $rados_package     = 'bareos-filedaemon-ceph-plugin',
    $glusterfs_package = 'bareos-filedaemon-glusterfs-plugin',
    $vmware_package    = 'bareos-vmware-plugin',
) {

    include repo
    include filedaemon
    
    $packages = [
        $python_package,
        $ldap_package,
        $ceph_package,
        $glusterfs_package,
        $vmware_package,
    ]

    @package {$packages:
        ensure  => installed,
        require => $repo::require,
    }

}
