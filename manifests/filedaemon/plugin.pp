
class bareos::filedaemon::plugin (
    $python_package    = 'bareos-filedaemon-python-plugin',
    $bpipe_package     = $bareos::filedaemon::package_name,
    $ldap_package      = 'bareos-filedaemon-ldap-python-plugin',
    $ceph_package      = 'bareos-filedaemon-ceph-plugin',
    $rados_package     = 'bareos-filedaemon-ceph-plugin',
    $glusterfs_package = 'bareos-filedaemon-glusterfs-plugin',
    $vmware_package    = 'bareos-vmware-plugin',
) {

    include bareos::global
    include bareos::repo
    include bareos::filedaemon
    
    $packages = [
        $python_package,
        $ldap_package,
        $ceph_package,
        $glusterfs_package,
        $vmware_package,
    ]

    @package {$packages:
        ensure  => $bareos::global::package_ensure,
        require => $bareos::repo::require,
    }

}
