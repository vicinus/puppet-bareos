
class bareos (
    $confdir = $bareos::params::confdir,
) inherits bareos::params {

    file {$confdir:
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
    }

}
