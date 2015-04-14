actions :delete
default_action :install

attribute :name,        kind_of:String, default:"default"
attribute :user,        kind_of:String, default:node.minimart.user
attribute :version,     kind_of:String, default:node.minimart.version
attribute :install_dir, kind_of:String, default:node.minimart.install_dir
attribute :listen,      kind_of:String, default:node.minimart.listen
attribute :base_url,    kind_of:String, default:node.minimart.base_url
attribute :poll_interval, kind_of:String, default:node.minimart.poll_interval
attribute :chef_server, kind_of:String, required:true
attribute :client,      kind_of:String, required:true
attribute :pem,         kind_of:String, required:true
attribute :skip_ssl,    kind_of:[TrueClass,FalseClass], default:node.minimart.skip_ssl
