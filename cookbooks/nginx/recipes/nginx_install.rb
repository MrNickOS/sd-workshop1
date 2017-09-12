template '/etc/yum.repos.d/nginx.repo' do
  source 'nginx.repo.erb'
end

bash 'install nginx' do
  code <<-EOH
  yum -y install nginx
  systemctl stop firewalld
  systemctl mask firewalld
  yum -y install iptables-services
  systemctl enable iptables
  service network restart
  EOH
end
