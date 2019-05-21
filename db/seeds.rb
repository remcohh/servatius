# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Instrument.create(id: 1, name: 'Soprano Sax', family: 'saxophone')
Instrument.create(id: 2, name: 'Alto Sax', family: 'saxophone')
Instrument.create(id: 3, name: 'Tenor Sax', family: 'saxophone')
Instrument.create(id: 4, name: 'Baritone Sax', family: 'bass')

Instrument.create(id: 5, name: 'Trombone', family: 'trombone')
Instrument.create(id: 6, name: 'Trumpet', family: 'trumpet')
Instrument.create(id: 7, name: 'Tenor Horn', family: 'horn')
Instrument.create(id: 8, name: 'Baritone Horn', family: 'horn')
Instrument.create(id: 9, name: 'Sousaphone', family: 'bass')

Instrument.create(id: 10, name: 'Snare Drum', family: 'percussion')
Instrument.create(id: 11, name: 'Bass Drum', family: 'percussion')
Instrument.create(id: 12, name: 'Triangle', family: 'percussion')


# Soprano saxes


# Tenor saxes
Member.create(email: 'remcohh@gmail.com', password: 'test123',
              password_confirmation: 'test123',
              first_name: 'Remco', last_name: 'Huijdts',
              gig_admin: true, admin: true, instrument: Instrument.find(6))
