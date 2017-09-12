#include_recipe 'mysql::mariadb_install'
#include_recipe 'mysql::mariadb_config'

include_recipe 'mysql::mysql_install'
include_recipe 'mysql::mysql_config'
