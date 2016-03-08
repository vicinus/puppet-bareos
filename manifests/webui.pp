
class bareos::webui extends bareos::params {

    include repo
    
    package {$::bareos::params::package_webui:
        ensure => installed,
    }

}
