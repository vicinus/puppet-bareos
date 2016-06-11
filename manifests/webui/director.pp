
define bareos::webui::director (
    $director_name = $title,
    $enabled       = true,
    $address,
    $port          = $params::director_port,
) {

    include params
    include webui
    
    concat::fragment {"${webui::directors_conf}+${director_name}":
        target  => $webui::directors_conf,
        order   => "05_${director_name}",
        content => template('bareos/webui/director.ini.erb'),
    }

}
