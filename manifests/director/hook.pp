
define bareos::director::hook (
    $job,
    $hook_name        = $title,
    $when             = 'Always',
    $shell_commands   = [],
    $ensure_shell     = false,
    $console_commands = [],
    $on               = 'client',
    $on_success       = true,
    $on_failure       = false,
    $fail_job         = false,
) {
    include bareos::director
    
    $dir = "${$bareos::director::jobs_conf}.d/${job}"
    
    file {"${dir}/${hook_name}.conf":
        ensure  => file,
        owner   => $bareos::director::user,
        group   => $bareos::director::group,
        mode    => '0600',
        content => template('bareos/director/hook.conf.erb'),
        require => File[$dir],
        notify  => Service[$bareos::director::service_name],
    }
}
