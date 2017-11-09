
class bareos (
    $confdir = $bareos::params::confdir,
    $pki_keypair       = "/etc/bareos/${fqdn}.pem",
    $pki_master_key    = "/etc/bareos/master.cert",
) inherits bareos::params {

    file {$confdir:
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
    }

}
