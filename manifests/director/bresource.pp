
define bareos::director::bresource($conf) {
    include director

    $clients_conf = "${director::conf_d}/${title}.conf"
    concat::fragment {"${director::conf}+${conf}":
        target  => $director::conf,
        order   => '10',
        content => "@${conf}\n",
    }
    concat {$conf:
        ensure  => present,
        owner   => $director::user,
        group   => $director::group,
        mode    => '0640',
        notify  => Service[$director::service_name],
        require => File[$director::conf_d],
    }
    concat::fragment {$conf:
        target  => $conf,
        order   => '01',
        content => "# Managed by puppet!\n",
    }
    
    file {"${conf}.d":
        ensure  => directory,
        owner   => $director::user,
        group   => $director::group,
        mode    => '0755',
        recurse => true,
        purge   => true,
        force   => true,
        require => Concat[$conf],
    }
}
