require 'csv'

namespace :import do

  desc "Import all"
  task :all => :environment do
    ensembles
    instruments
    ensemble_instruments
    members
    rehearsals
    gigs
  end

  desc "Import members from CSV"
  task :members => :environment do
    members
  end

  desc "Create ensembles"
  task :ensembles => :environment do
    ensembles
  end


  desc "Create instruments"
  task :instruments => :environment do
    instruments
  end

  desc "Create ensemble_instruments"
  task :ensemble_instruments => :environment do
    ensemble_instruments
  end

  desc "Create rehearsals"
  task :rehearsals => :environment do
    rehearsals
  end

  desc "Create rehearsals"
  task :gigs => :environment do
    gigs
  end

  desc "Create band"
  task :band => :environment do
    Band.create({name: 'Fanfare sint servatius', id: 1})
  end

  private

  def members
    csv_file_path = 'db/members.csv'
    MemberPresence.delete_all
    Member.all.each{ |m| m.ensemble_instruments.clear }
    Member.destroy_all
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
      puts "Member added!"
    end
  end

  def ensembles
    EnsembleInstrument.delete_all
    Ensemble.destroy_all
    CSV.foreach('db/ensembles.csv') do |row|
      next if row[0] == 'id'
      Ensemble.create!({
                           id: row[0],
                           name: row[1],
                           band_id: row[2]
                       })
      puts "Ensemble added!"
    end
  end

  def instruments
    Ensemble.all.each{|e| e.ensemble_instruments.delete_all}
    Instrument.destroy_all
    CSV.foreach('db/instruments.csv') do |row|
      next if row[0] == 'id'
      Instrument.create!({
                             id: row[0],
                             name: row[1],
                         })
      puts "Instrument added!"
    end
  end

  def ensemble_instruments
    Ensemble.all.each{|e| e.ensemble_instruments.delete_all}
    EnsembleInstrument.destroy_all
    CSV.foreach('db/ensemble_instruments.csv') do |row|
      next if row[0] == 'id'
      EnsembleInstrument.create!({
                                     id: row[0],
                                     ensemble_id: row[1],
                                     instrument_id: row[2],
                                     party: row[3]
                                 })
      puts "Ensemble instrument added!"
    end
  end

  def rehearsals
    Rehearsal.all.each{ |r| r.ensembles.clear }
    Rehearsal.destroy_all
    CSV.foreach('db/rehearsals.csv') do |row|
      next if row[0] == 'id'
      Rehearsal.create!({
                                     id: row[0],
                                     band_id: row[1],
                                     description: row[2],
                                     date_time: row[3],
                                     ensemble_ids: row[4]
                                 })
      puts "Rehearsal added!"
    end
  end

  def gigs
    Gig.all.each{ |g| g.ensembles.clear }
    Gig.destroy_all
    CSV.foreach('db/gigs.csv') do |row|
      next if row[0] == 'id'
      Gig.create!({
                            id: row[0],
                            band_id: row[1],
                            title: row[2],
                            date_time: row[3],
                            ensemble_ids: row[4]
                        })
      puts "Gig added!"
    end
  end

end