bash 'restart network' do
  code <<-EOH
  systemctl stop firewalld
  systemctl mask firewalld
  yum -y install iptables-services
  systemctl enable iptables
  service network restart
  EOH
end

bash 'add repo' do
   user 'root'
   code <<-EOH
   yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
   yum -y install mysql-community-server
   EOH
 end
