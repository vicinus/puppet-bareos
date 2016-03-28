
class bareos::repo (
    $version = 'latest',
) {

    include global
            
    if $version == 'nightly' {
        $repo_path = 'experimental/nightly'
    } else {
        $repo_path = "release/${version}"
    }
    
    $bareos_repo_base = 'http://download.bareos.org/bareos'

    if $global::repo_manage {
    
        case $::osfamily {
            'Debian': {
            
                apt::source {$global::repo_name:
                    location    => "${bareos_repo_base}/${repo_path}/${::operatingsystem}_${::operatingsystemmajrelease}.0/",
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
