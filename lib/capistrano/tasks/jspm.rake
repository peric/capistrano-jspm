namespace :jspm do
  desc <<-DESC
        Install the current jspm environment. Command is executed without any other arguments.\

        You can override any of these defaults by setting the variables shown below.

          set :jspm_roles, :web
          set :jspm_bin, :jspm
  DESC
  task :install do
    on roles fetch(:jspm_roles) do
      within "#{release_path}" do
        execute fetch(:jspm_bin), 'install'
      end
    end
  end

  before 'deploy:updated', 'jspm:install'

  desc <<-DESC
        Prepare a bundle for production.\

        This task is completely optional and if you want to run it on every deployment \
        before deploy:updated, add this to your deploy.rb.

          before 'deploy:updated', 'jspm:build' do
            invoke 'jspm:build',
                   'path/for/fromfile/app.js',
                   'path/for/tofile/app.min.js'
          end

        You can override any of these defaults by setting the variables shown below.

          set :jspm_build_flags, '--minify'
  DESC
  task :build, [:from_file, :to_file] do |task, args|
    on roles fetch(:jspm_roles) do
      within "#{release_path}" do
        unless args[:from_file]
          raise 'Missing from_file argument.'
        end
        unless args[:to_file]
          raise 'Missing to_file argument.'
        end

        execute fetch(:jspm_bin),
                'build',
                fetch(:jspm_build_flags),
                args[:from_file],
                args[:to_file]
      end
    end
  end
end

namespace :load do
  task :defaults do
    set :jspm_roles, :web
    set :jspm_bin, :jspm
    set :jspm_build_flags, '--minify'
  end
end
