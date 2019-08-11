require 'csv'

namespace :import do

  desc "Import members from CSV"
  task :members => :environment do

    csv_file_path = 'db/members.csv'
    MemberPresence.delete_all
    Member.delete_all
    CSV.foreach(csv_file_path) do |row|
      next if row[0] == 'id'
      Member.create!({
                         id: row[0],
                         band_id: row[1],
                         email: row[2],
                         first_name: row[3],
                         last_name: row[4],
                         phone_number: row[5],
                         admin: row[6],
                         role: row[7],
                         ensemble_instrument_ids: row[8],
                         password: row[9],
                         password_confirmation: row[9],


                     })
      puts "Row added!"
    end
  end

  desc "Create ensembles"
  task :ensembles => :environment do
    CSV.foreach(csv_file_path) do |row|
      next if row[0] == 'id'
      Member.create!({
                         id: row[0],
                         name: row[1],
                     })
      puts "Row added!"
    end
  end

  desc "Create band"
  task :band => :environment do
    Band.create({name: 'Fanfare sint servatius', id: 1})
  end
end