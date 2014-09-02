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
  status  => 'enabled',
  restart_on_change => true,    #Under normal circumstances a modification to the Logstash configuration will trigger a restart of the service.
  install_contrib => true,      #install contrib plugins
}


}#END