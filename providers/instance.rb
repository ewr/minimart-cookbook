include Chef::DSL::IncludeRecipe
use_inline_resources

action :install do
  # make sure our user and directory exist
  #user new_resource.user do
  #  action      :create
  #  home        new_resource.install_dir
  #  manage_home false
  #end

  directory new_resource.install_dir do
    action    :create
    owner     new_resource.user
    recursive true
  end

  svc_name = "minimart-#{new_resource.name}"

  service svc_name do
    action    :nothing
    provider  Chef::Provider::Service::Upstart
    supports  [:start,:stop,:restart,:enable,:disable]
  end

  arch  = case node.kernel.machine
  when "x86_64"
    "amd64"
  else
    raise "Minimart binaries not available for this architecture: #{node.kernel.machine}"
  end

  os    = node.os

  slug  = [os,arch,new_resource.version].join("-")

  include_recipe "tarball"

  tarball_x "#{new_resource.install_dir}/minimart.tgz" do
    destination new_resource.install_dir
    owner       new_resource.user
    action      :nothing
    notifies    :restart, "service[#{svc_name}]"
  end

  remote_file "#{new_resource.install_dir}/minimart.tgz" do
    source    "#{node.minimart.binary_url}/v#{new_resource.version}/minimart-#{slug}.tar.gz"
    checksum  node.minimart.sha[slug]
    mode      0755
    notifies  :extract, "tarball_x[#{new_resource.install_dir}/minimart.tgz]"
  end

  options = {
    "chef.server"   => new_resource.chef_server,
    "baseURL"       => new_resource.base_url,
    "chef.client"   => new_resource.client,
    "chef.interval" => new_resource.poll_interval,
    "chef.pem"      => new_resource.pem,
    "listen"        => new_resource.listen,
    "skip-ssl"      => new_resource.skip_ssl,
  }

  template "/etc/init/#{svc_name}.conf" do
    action    :create
    source    "minimart.upstart.erb"
    cookbook  "minimart"
    variables({
      resource:   new_resource,
      options:    options,
      service:    svc_name,
    })
    notifies :enable, "service[#{svc_name}]"
    notifies :start,  "service[#{svc_name}]"
  end

end

#----------

action :delete do

end