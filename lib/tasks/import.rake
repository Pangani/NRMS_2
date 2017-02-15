require 'csv'

desc "Importing a RUTF ration CSV file into table"
namespace :db do
	task :import_csv, [:filename] => :environment do
		CSV.foreach('lib/tasks/rutf_ration.csv', :headers => true) do |row|
			Foodration.create!(row.to_hash)
		end
	end
end
# 	

#Then run "bundle exec rake db:import_csv"