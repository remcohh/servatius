# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Instrument.create(id: 1, name: 'Bugel 1', family: 'Bugels')
Instrument.create(id: 2, name: 'Bugel 2', family: 'Bugels')
Instrument.create(id: 3, name: 'Bugel 3', family: 'Bugels')

Instrument.create(id: 4, name: 'Trompet 1', family: 'Trompet')
Instrument.create(id: 5, name: 'Trompet 2', family: 'Trompet')
Instrument.create(id: 6, name: 'Trompet 3', family: 'Trompet')

Instrument.create(id: 7, name: 'Sopraan sax', family: 'Sax')
Instrument.create(id: 8, name: 'Alt sax 1', family: 'Sax')
Instrument.create(id: 9, name: 'Alt sax 2', family: 'Sax')

Instrument.create(id: 10, name: 'Trombone 1', family: 'Trombone')
Instrument.create(id: 11, name: 'Trombone 2', family: 'Trombone')
Instrument.create(id: 12, name: 'Bas trombone', family: 'Trombone')

Instrument.create(id: 13,name: 'Bariton / Euphonium 1', family: 'Tuba')
Instrument.create(id: 14, name: 'Bariton / Euphonium 2', family: 'Tuba')
Instrument.create(id: 15, name: 'Bariton / Euphonium 2', family: 'Tuba')
Instrument.create(id: 16, name: 'Es Bas', family: 'Bas')
Instrument.create(id: 17, name: 'Bes Bas', family: 'Bas')

Instrument.create(id: 18, name: 'Hoorn 1', family: 'Hoorn')
Instrument.create(id: 19, name: 'Hoorn 2', family: 'Hoorn')
Instrument.create(id: 20,name: 'Hoorn 3', family: 'Hoorn')

Instrument.create(id: 21, name: 'Slagwerk', family: 'Slagwerk')
Instrument.create(id: 22, name: 'Tamboer', family: 'Slagwerk')
Instrument.create(id: 23, name: 'Overslag', family: 'Slagwerk')
Instrument.create(id: 24, name: 'Tenor trom', family: 'Slagwerk')


# Soprano saxes


# Tenor saxes
 Member.create(email: 'remcohh@gmail.com', password: 'test123', password_confirmation: 'test123', first_name: 'Remco', last_name: 'Huijdts', admin: true, band_id: 1)
