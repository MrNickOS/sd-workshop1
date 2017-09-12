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

#courses = node[:courses]
#node[courses].each do |course|
#	puts "<h1>#{course}</h1>"

#template '/var/www/html/courses.html' do
#	source 'courses.erb'
#	mode 0644
#	owner 'root'
#	group 'wheel'
#	variables(
#		:courses => node[:courses]
#	)
#end
