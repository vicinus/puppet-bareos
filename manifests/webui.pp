
class bareos::webui (
    $package_name   = $params::webui_package,
    $profile_name   = $params::webui_profile_name,
    $conf_d         = $params::webui_conf_d,
    $directors_conf = $params::webui_directors_conf,
    $data_dir       = $params::webui_data_dir,
    $public_dir     = $params::webui_public_dir,
    $user           = $params::webui_user,
    $group          = $params::webui_group,
    $manage_profile = false,
) inherits params {

    include global
    include repo
    
    package {$package_name:
        ensure  => $global::package_ensure,
        require => $repo::require,
    }
    
    file {$data_dir:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => Package[$package_name],
    }
    
    file {$public_dir:
        ensure => directory,
        owner  => $user,
        group  => $group,
        mode   => '0755',
        require => File[$data_dir],
    }
    
    file {$conf_d:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
        require => Package[$package_name],
    }
    
    ->
    
    concat {$directors_conf:
        ensure => present,
        owner  => $user,
        group  => $group,
        mode   => '0644',
    }
    
    concat::fragment {$directors_conf:
        target  => $directors_conf,
        order   => '01',
        content => "; Managed by puppet !\n"
    }
    
    if $manage_profile {

        director::profile {$profile_name:
            options => {
                'Command ACL'  => 'status, messages, show, version, run, rerun, cancel, .api, .bvfs_*, list, llist, use, restore, .jobs, .filesets, .clients',
                'Job ACL'      => '*all*',
                'Schedule ACL' => '*all*',
                'Catalog ACL'  => '*all*',
                'Pool ACL'     => '*all*',
                'Storage ACL'  => '*all*',
                'Client ACL'   => '*all*',
                'FileSet ACL'  => '*all*',
                'Where ACL'    => '*all*'
            }
        }
    
    }

}
