
class bareos::repo (
    $version = 'latest',
) {

    include bareos::global
            
    if $version == 'nightly' {
        $repo_path = 'experimental/nightly'
    } else {
        $repo_path = "release/${version}"
    }
    
    $bareos_repo_host = 'download.bareos.org'
    $bareos_repo_base = "http://${bareos_repo_host}/bareos"

    if $bareos::global::repo_manage {
    
        case $::osfamily {
            'Debian': {
                apt::source { $bareos::global::repo_name:
                  location => "${bareos_repo_base}/${repo_path}/${::operatingsystem}_${::operatingsystemmajrelease}.0",
                  include => {'deb' => true},
                  repos => '/',
                  key => '0143857D9CE8C2D182FE2631F93C028C093BFBA2',
                  release => '',
                }
            
                ->

                ::apt::pin {$bareos::global::repo_name:
                    priority => 1000,
                    origin   => $bareos_repo_host,
                }
                
                $require = Apt::Source[$bareos::global::repo_name]
            }
        }
        
    } else {
      $require = undef
    }

}
