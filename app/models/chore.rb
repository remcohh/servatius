class Chore < ApplicationRecord
  belongs_to :band
  belongs_to :coordinator, class_name: 'Member'
end
