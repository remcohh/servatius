class Group < ApplicationRecord
  filterrific(
      default_filter_params: { sorted_by: "name asc" },
      available_filters: [
          :sorted_by,
          :name_filter
      ],
  )

  scope :name_filter, ->(name) {
    where('lower(name) like ?', "%#{name.downcase}%")
  }

  scope :sorted_by, ->(o) {
    order("created_at")
  }

  has_and_belongs_to_many :members
  belongs_to :band
  has_many :messages, as: :messageable

end
