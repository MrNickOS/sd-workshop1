#yum_package 'httpd' do
#  action :install
#end

yum_package 'php' do
  action :install
end

yum_package 'php-mysql' do
  action :install
end

bash 'add repo' do
  user 'root'
  code <<-EOH
  yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
  yum -y install mysql-community-server
  setsebool -P httpd_can_network_connect=1
  EOH
end
