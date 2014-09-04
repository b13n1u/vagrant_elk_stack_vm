class vagrant_elk_stack::logst{

#LOGSTASH setup
include apt
#add logstash 1.4 repo
apt::source { 'logstash':
  location    => 'http://packages.elasticsearch.org/logstash/1.4/debian',
  release     => 'stable',
  repos       => 'main',
  key         => 'D88E42B4',
  key_source  => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  include_src => false,
}->

class { 'logstash': 
#  version => '1.4.2-1-2c0f5a1',
  status            => 'enabled',
  restart_on_change => false,    #Under normal circumstances a modification to the Logstash configuration will trigger a restart of the service.
  install_contrib   => true,      #install contrib plugins
  init_defaults_file => 'puppet:///modules/vagrant_elk_stack/logstash'
  
}

logstash::configfile { 'input_conf':
  source => 'puppet:///modules/vagrant_elk_stack/input.conf',
#   content => template("vagrant_elk_stack/input.conf"),     #stupid bug in module !!
   order  => 10
 }

logstash::configfile { 'filter_conf':
  source => 'puppet:///modules/vagrant_elk_stack/filter.conf',
#   content => template("vagrant_elk_stack/filter.conf"),     #stupid bug in module !!
   order  => 20
 }


logstash::patternfile { 'patterns_conf':
   source => 'puppet:///modules/vagrant_elk_stack/patterns.conf'
 }

logstash::configfile { 'output_conf':
  source => 'puppet:///modules/vagrant_elk_stack/output.conf',
#   content => template("vagrant_elk_stack/output.conf"),     #stupid bug in module !!
   order  => 30
}

}#END