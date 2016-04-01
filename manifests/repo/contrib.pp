
class bareos::repo::contrib {

    include global

    if $global::repo_manage {
    
        case $::osfamily {
            'Debian': {
            
                # puppetlabs-apt 2.x is not able to specify an empty release, so directly create the apt::setting resource here
            
                $setting      = "list-${global::contrib_repo_name}"
                $_include     = {'deb' => true}
                $location     = "${bareos_repo_base}/${repo_path}/${::operatingsystem}_${::operatingsystemmajrelease}.0"
                $repos        = '/'
                $comment      = $global::contrib_repo_name
                $architecture = false
                
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
