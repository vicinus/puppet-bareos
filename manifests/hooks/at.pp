
define bareos::hooks::at (
    $file_name  = $title,
    $for,
    $default    = true,
    $when       = 'Always',
    $on         = 'client',
    $on_success = true,
    $on_failure = false,
    $fail_job   = false,
) {

    include hooks
    
    director::hook {"generic_hook_${title}":
        for        => $for,
        default    => $default,
        do         => "${hooks::prefix}/${file_name}",
        when       => $when,
        as         => 'Command',
        on         => $on,
        on_success => $on_success,
        on_failure => $on_failure,
        fail_job   => $fail_job,
    }

}
