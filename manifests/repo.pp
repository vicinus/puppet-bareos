
class bareos::repo {

    $repo_name = 'bareos'

    apt::source {$repo_name:
        location    => "http://download.bareos.org/bareos/release/latest/${::operatingsystem}_${::operatingsystemmajrelease}.0/",
        release     => '',
        repos       => '/',
        include_deb => true,
        include_src => false,
        key         => '0143857D9CE8C2D182FE2631F93C028C093BFBA2',
        pin         => 1000,
    }
    
    $require = Apt::Source[$repo_name]


}
