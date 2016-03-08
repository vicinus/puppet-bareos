
class bareos::client inherits bareos::params {

    include repo
    
    class {'filedaemon':
        # TODO client specifics
    }
    
}
