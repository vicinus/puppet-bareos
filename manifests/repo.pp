
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
            
                # puppetlabs-apt 2.x is not able to specify an empty release, so directly create the apt::setting resource here
            
                $setting  = "list-${global::repo_name}"
                $_include = {'deb' => true}
                $location = "${bareos_repo_base}/${repo_path}/${::operatingsystem}_${::operatingsystemmajrelease}.0"
                $repos    = '/'
                $comment  = $global::repo_name
                
                ::apt::key {'0143857D9CE8C2D182FE2631F93C028C093BFBA2':}
                
                ->
            
                ::apt::setting {$setting:
                    ensure  => present,
                    content => template('apt/_header.erb', 'apt/source.list.erb'),
                }
                
                $require = Apt::Setting[$setting]
            }
        }
        
    }

}
