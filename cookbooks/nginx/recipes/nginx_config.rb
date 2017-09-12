bash 'open port' do
	code <<-EOH
	iptables -I INPUT  -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT
	service iptables save
	EOH
end

template '/etc/nginx/nginx.conf' do
	source 'nginx.conf.erb'
end

bash 'run nginx' do
	code <<-EOH
	service httpd stop
	nginx
	EOH
end
