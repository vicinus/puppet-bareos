
define bareos::webui::director (
    $director_name = $title,
    $enabled       = true,
    $address,
    $port,
) {

    include webui
    
    concat::fragment {"${webui::directors_conf}+${director_name}":
        target  => $webui::directors_conf,
        order   => '05',
        content => template('bareos/webui/director.ini.erb'),
    }

}
