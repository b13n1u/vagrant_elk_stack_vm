class vagrant_elk_stack::elastic{
#ELASTICSEARCH setup
#add elasticsearch 1.3 repo
include apt
apt::source { 'elasticsearch':
  location    => 'http://packages.elasticsearch.org/elasticsearch/1.3/debian',
  release     => 'stable',
  repos       => 'main',
  key         => 'D88E42B4',
  key_source  => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  include_src => false,
}-> 

class { 'elasticsearch':
#  version      => '1.3.2',    #hold on this version
  manage_repo  => false,      #dont try the ES repo
  java_install => true,       #try to install java
  status       => 'enabled',  #make sure the service is started
  #datadir => '/var/lib/elasticsearch-data',      #global data dir (rather use instance dir)
} -> 

service { 'elasticsearch': 
  ensure => 'running',
  enable => true, 
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
  datadir => '/vagrant/es-data-es01'
}

}#END
