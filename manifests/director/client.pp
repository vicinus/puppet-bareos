
define bareos::director::client (
    $password,
    $enabled  = true,
    $address  = $::fqdn,
    $port     = $bareos::params::filedaemon_port,
    $catalog  = undef,
    $options  = {},
    $includes = [],
) {

    include bareos::params
    include bareos::director

    $daemon_name = $title

    if $catalog {
        realize Catalog[$catalog]
    }

    concat::fragment {"${bareos::director::clients_conf}+${daemon_name}":
        target  => $bareos::director::clients_conf,
        order   => "05_${daemon_name}",
        content => template('bareos/director/client.conf.erb'),
    }
}
