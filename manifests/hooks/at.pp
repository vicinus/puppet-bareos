
define bareos::hooks::at (
    $job,
    $file_name  = $title,
    $when       = 'Always',
    $on         = 'client',
    $on_success = true,
    $on_failure = false,
    $fail_job   = false,
) {

    include bareos::hooks

    bareos::director::hook {"generic_hook_${title}":
        job            => $job,
        shell_commands => ["${bareos::hooks::prefix}/${file_name}"],
        when           => $when,
        on             => $on,
        on_success     => $on_success,
        on_failure     => $on_failure,
        fail_job       => $fail_job,
    }

}
