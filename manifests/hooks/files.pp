
define bareos::hooks::files (
    $base  = $title,
) {
    include bareos
    include bareos::hooks
    
    $do = $base
    file {$do:
        ensure  => file,
        owner   => $bareos::hooks::user,
        group   => $bareos::hooks::group,
        mode    => '0700',
        source  => 'puppet:///modules/bareos/hook.sh',
        require => File[$bareos::confdir],
    }
    
    ->
    
    file {"${base}.d":
        ensure => directory,
        owner  => $bareos::hooks::user,
        group  => $bareos::hooks::group,
        mode   => '0755',
    }
}
