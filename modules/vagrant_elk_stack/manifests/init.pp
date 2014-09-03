#TODO: add config, prepare the directories 
class vagrant_elk_stack {

include vagrant_elk_stack::elastic
include vagrant_elk_stack::logst
include vagrant_elk_stack::kiban
include apt 

#pkgs which may be needed
$basic_pkgs = [ "screen", "strace", "sudo", "htop", "vim", "python-pip", "apache2", "curl" ]
#"libaugeas-ruby", "augeas-tools", "libaugeas-dev" ]
package { $basic_pkgs:
  ensure => "installed",
}

}#END


