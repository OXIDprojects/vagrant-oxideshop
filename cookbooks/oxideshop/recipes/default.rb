#package "git-core" do
#  action :install
#end

git "#{node[:oxideshop][:dir]}" do
  repository "#{node[:oxideshop][:git_repository]}"
  reference "#{node[:oxideshop][:git_revision]}"
  action :sync
end   

#bash "clone oxideshop" do
#  code <<-EOH
#    git clone "#{node[:oxideshop][:git_repository]}" "#{node[:oxideshop][:dir]}"
#  EOH
#end

directory node[:oxideshop][:dir] do
  owner "vagrant"
  mode "0755"
  action :create
end

directory "#{node[:oxideshop][:dir]}/log" do
  owner "vagrant"
  mode "0755"
  action :create
end
    
bash "setup_oxideshop" do
  code <<-EOH
    mysql             -u#{node[:oxideshop][:mysql_username]} -p#{node[:oxideshop][:mysql_password]} -e "CREATE DATABASE #{node[:oxideshop][:mysql_database]} "
    mysql -D#{node[:oxideshop][:mysql_database]} -u#{node[:oxideshop][:mysql_username]} -p#{node[:oxideshop][:mysql_password]} <#{node[:oxideshop][:dir]}/source/setup/sql/database.sql
    mysql -D#{node[:oxideshop][:mysql_database]} -u#{node[:oxideshop][:mysql_username]} -p#{node[:oxideshop][:mysql_password]} <#{node[:oxideshop][:dir]}/source/setup/sql/demodata.sql
  EOH
  # creates "/usr/local/bin/redis-server"
end

template "config.inc.php" do
  path "#{node[:oxideshop][:dir]}/source/config.inc.php"
  source "config.inc.php.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

template "runtests" do
  path "#{node[:oxideshop][:dir]}/tests/runtests"
  source "runtests.erb"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end


template "resetdb" do
  path "#{node[:oxideshop][:dir]}/../tools/resetdb"
  source "resetdb.erb"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end


directory "#{node[:oxideshop][:dir]}/tmp" do
  mode 0755
  owner "vagrant"
  action :create
end