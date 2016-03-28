
define bareos::director::hook (
    $hook_name        = $title,
    $job,
    $when             = 'Always',
    $shell_commands   = [],
    $ensure_shell     = false,
    $console_commands = [],
    $on               = 'client',
    $on_success       = true,
    $on_failure       = false,
    $fail_job         = false,
) {
    include director
    
    $dir = "${$director::jobs_conf}.d/${job}"
    
    file {"${dir}/${hook_name}.conf":
        ensure  => file,
        owner   => $director::user,
        group   => $director::group,
        mode    => '0600',
        content => template('bareos/director/hook.conf.erb'),
        require => File[$dir],
        notify  => Service[$director::service_name],
    }
}
