
class bareos::webui extends bareos::params {

    include global
    include repo
    
    package {$::bareos::params::package_webui:
        ensure => $global::package_ensure,
    }

}
