#TODO: add config, prepare the directories 
class vagrant_elk_stack {

include vagrant_elk_stack::elastic
include vagrant_elk_stack::logst
include vagrant_elk_stack::kiban
include apt 

class { 'timezone':
    timezone => 'Europe/Warsaw',
}


#pkgs which may be needed
$basic_pkgs = [ "screen", "strace", "sudo", "htop", "vim", "python-pip", "apache2", "curl", "tmux" ]
#"libaugeas-ruby", "augeas-tools", "libaugeas-dev" ]
package { $basic_pkgs:
  ensure => "installed",
}

file { '/root/startLS.sh': 
  ensure => file, 
  content => 'GEM_HOME="/opt/logstash/vendor/bundle/jruby/1.9/" /usr/bin/java -Djava.io.tmpdir=/var/lib/logstash -Xmx500m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -jar /opt/logstash/vendor/jar/jruby-complete-1.7.11.jar  -I/opt/logstash/lib /opt/logstash/lib/logstash/runner.rb agent -f /etc/logstash/conf.d -l /var/log/logstash/logstash.log',
  mode => 775,
}

file { '/root/reloadConf.sh': 
  ensure => file, 
  content => 'puppet apply --modulepath /tmp/vagrant-puppet-3/modules-0:/etc/puppet/modules --manifestdir /tmp/vagrant-puppet-3/manifests --detailed-exitcodes /tmp/vagrant-puppet-3/manifests/default.pp',
  mode => 775,
}


file {'/etc/tmux.conf': 
  ensure => file,
  source => 'puppet:///modules/vagrant_elk_stack/tmux.conf',
  
}

 


}#END


