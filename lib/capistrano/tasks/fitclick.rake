namespace :fitclick do
  desc 'Run rake fitclick:crawl'
  task :crawl do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'fitclick:crawl'
        end
      end
    end
  end
end
