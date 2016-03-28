
define bareos::hooks::files (
    $base  = $title,
) {
    include hooks
    include bareos
    
    $do = "${base}"
    file {$do:
        ensure  => file,
        owner   => $hooks::user,
        group   => $hooks::group,
        mode    => '0700',
        source  => 'puppet:///modules/bareos/hook.sh',
        require => File[$bareos::confdir],
    }
    
    ->
    
    file {"${base}.d":
        ensure => directory,
        owner  => $hooks::user,
        group  => $hooks::group,
        mode   => '0755',
    }
}
