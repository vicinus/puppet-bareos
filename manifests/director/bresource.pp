
define bareos::director::bresource($conf) {
    include bareos::director

    $clients_conf = "${bareos::director::conf_d}/${title}.conf"
    concat::fragment {"${bareos::director::conf}+${conf}":
        target  => $bareos::director::conf,
        order   => '10',
        content => "@${conf}\n",
    }
    concat {$conf:
        ensure  => present,
        owner   => $bareos::director::user,
        group   => $bareos::director::group,
        mode    => '0640',
        notify  => Service[$bareos::director::service_name],
        require => File[$bareos::director::conf_d],
    }
    concat::fragment {$conf:
        target  => $conf,
        order   => '01',
        content => "# Managed by puppet!\n",
    }
    
    file {"${conf}.d":
        ensure  => directory,
        owner   => $bareos::director::user,
        group   => $bareos::director::group,
        mode    => '0755',
        recurse => true,
        purge   => true,
        force   => true,
        require => Concat[$conf],
    }
}
