
class bareos::repo {

    include global

    if $global::repo_manage {
    
        case $::osfamily {
            'Debian': {
                apt::source {$global::repo_name:
                    location    => "http://download.bareos.org/bareos/release/latest/${::operatingsystem}_${::operatingsystemmajrelease}.0/",
                    release     => '',
                    repos       => '/',
                    include_deb => true,
                    include_src => false,
                    key         => '0143857D9CE8C2D182FE2631F93C028C093BFBA2',
                    pin         => 1000,
                }
                
                $require = Apt::Source[$global::repo_name]
            }
        }
        
    }

}
