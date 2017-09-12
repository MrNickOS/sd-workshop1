cookbook_file '/var/www/html/index.html' do
	source 'index.html'
	mode 0644
	owner 'root'
	group 'wheel'
end

cookbook_file '/var/www/html/select.php' do
		source 'select.php'
		mode 0644
		owner 'root'
		group 'wheel'
end

cookbook_file '/var/www/html/info.php' do
		source 'info.php'
		mode 0644
		owner 'root'
		group 'wheel'
end
