default.minimart.binary_url = "https://github.com/ewr/minimart/releases/download"

default.minimart.version = "0.1.1"
default.minimart.sha = {
  "linux-amd64-0.1.1" => "ef8e1361e6ea6e585e1e8478666b116ec1d7fd38d3e8497daf020e40d9a5f354"
}

default.minimart.install_method = "binary"
default.minimart.user           = "minimart"
default.minimart.listen         = ":8080"
default.minimart.install_dir    = "/opt/minimart"
default.minimart.skip_ssl       = false
default.minimart.base_url       = "http://#{node.ipaddress}#{node.minimart.listen}"
default.minimart.poll_interval  = "5m"

# These must be filled in to use the default recipe (as opposed to the instance resource)
default.minimart.client         = nil
default.minimart.pem            = nil
default.minimart.chef_server    = nil