#service 'httpd' do
#    action [:enable, :start]
#end

bash 'restart network' do
  code <<-EOH
  systemctl stop firewalld
  systemctl mask firewalld
  yum -y install iptables-services
  systemctl enable iptables
  service network restart
  EOH
end

bash 'open port' do
  code <<-EOH
  iptables -I INPUT  -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
  service iptables save
  EOH
end
