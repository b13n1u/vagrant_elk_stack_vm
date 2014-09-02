#TODO: add config, prepare the directories 

class vagrant_elk_stack {

include apt 

#pkgs which may be needed
$basic_pkgs = [ "screen", "strace", "sudo", "htop", "vim", "python-pip", "apache2", "curl" ]
#"libaugeas-ruby", "augeas-tools", "libaugeas-dev" ]
package { $basic_pkgs:
  ensure => "installed",
}

#add elasticsearch 1.3 repo
apt::source { 'elasticsearch':
  location    => 'http://packages.elasticsearch.org/elasticsearch/1.3/debian',
  release     => 'stable',
  repos       => 'main',
  key         => 'D88E42B4',
  key_source  => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  include_src => false,
}

#add logstash 1.4 repo
apt::source { 'logstash':
  location    => 'http://packages.elasticsearch.org/logstash/1.4/debian',
  release     => 'stable',
  repos       => 'main',
  key         => 'D88E42B4',
  key_source  => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  include_src => false,
}

#ELASTICSEARCH setup
class { 'elasticsearch':
#  version      => '1.3.2',    #hold on this version
  manage_repo  => false,      #dont try the ES repo
  java_install => true,       #try to install java
  status       => 'enabled',  #make sure the service is started
  #datadir => '/var/lib/elasticsearch-data',      #global data dir (rather use instance dir)
} 

#install modules
elasticsearch::plugin{'lmenezes/elasticsearch-kopf':
  module_dir => 'kopf',
  instances => 'es-01',
}
elasticsearch::plugin{'royrusso/elasticsearch-HQ':
  module_dir => 'HQ',
  instances => 'es-01',
}
elasticsearch::plugin{'mobz/elasticsearch-head':
      module_dir => 'head',
      instances => 'es-01',
}

#add clients
#elasticsearch::python { 'rawes': }

##basic instance
elasticsearch::instance { 'es-01':
  datadir => '/var/lib/es-data-es01'
}


#LOGSTASH setup

class { 'logstash': 
#  version => '1.4.2-1-2c0f5a1',
  status  => 'enabled',
  restart_on_change => true,    #Under normal circumstances a modification to the Logstash configuration will trigger a restart of the service.
  install_contrib => true,
#  contrib_version => '1.4.2'
}

}#END


