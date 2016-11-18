
define bareos::webui::director (
    $address,
    $director_name = $title,
    $enabled       = true,
    $port          = $bareos::params::director_port,
    $catalog       = undef,
) {

    include bareos::params
    include bareos::webui
    
    concat::fragment {"${bareos::webui::directors_conf}+${director_name}":
        target  => $bareos::webui::directors_conf,
        order   => "05_${director_name}",
        content => template('bareos/webui/director.ini.erb'),
    }

}
