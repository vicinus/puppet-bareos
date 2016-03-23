
define bareos::director::hook (
    $hook_name        = $title,
    $for,
    $default          = false,
    $when             = 'Always',
    $shell_commands   = [],
    $console_commands = [],
    $on               = 'client',
    $on_success       = true,
    $on_failure       = false,
    $fail_job         = false,
) {
    include director
    
    if $default {
        $base = $director::jobdefs_conf
    } else {
        $base = $director::jobs_conf
    }
    
    $dir = "${base}.d/${for}"
    
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
