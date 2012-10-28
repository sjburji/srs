set :user, 'srspal'  # Your dreamhost account's username
set :domain, 'pulcherrima.dreamhost.com'  # Dreamhost servername where your account is located 
set :project, 'srs'  # Your application as its called in the repository
set :application, 'srspal.com'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup
set :deploy_via, :remote_cache
set :scm, :git

# version control config
set :scm_username, 'sjburji'
set :repository,  "git@github.com:sjburji/srs.git"

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

after "deploy:create_symlink", "deploy:create_file_link"
namespace :deploy do
  after "deploy:update_code" do
  	run "cp #{deploy_to}/shared/database.yml #{release_path}/config/database.yml"    
  	run "cp #{deploy_to}/shared/application.yml #{release_path}/config/application.yml"    
  end

  desc "set the create_file_link"
  task :create_file_link, :roles => :app do
    run "ln -s #{deploy_to}/data #{current_path}/public/data"
    run "ln -s #{deploy_to}/profiles #{current_path}/public/images/profiles"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end