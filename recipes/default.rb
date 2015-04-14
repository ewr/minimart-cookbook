#
# Cookbook Name:: minimart
# Recipe:: default
#

if !node.minimart.client || !node.minimart.pem
  raise "Minimart cannot install without a client and PEM file."
end

minimart_instance "default" do
  action      :install
  chef_server node.minimart.chef_server
  pem         node.minimart.pem
  client      node.minimart.client
  base_url    node.minimart.base_url
end
