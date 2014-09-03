class vagrant_elk_stack::kiban{
 
 #KIBANA setup
  class { 'kibana':
  install_url         => 'https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.zip',
  install_destination => '/var/www/',
  elasticsearch_url => "http://localhost:9200",
}
  
  
}#END