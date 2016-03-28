
class bareos (
    $confdir = $params::confdir,
) inherits params {

    file {$confdir:
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
    }

}
