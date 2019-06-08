class Band < ApplicationRecord
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

end
