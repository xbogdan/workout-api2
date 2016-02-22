namespace :db do
	desc 'Run db:reset db:migrate'
  task :reset do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:reset db:migrate'
        end
      end
    end
  end
end
