class Chore < ApplicationRecord
  belongs_to :band
  belongs_to :coordinator, class_name: 'Member'

  filterrific(
      default_filter_params: { sorted_by: "title asc" },
      available_filters: [
          :sorted_by,
          :title_filter
      ],
  )

  scope :title_filter, ->(title) {
    where('lower(title) like ?', "%#{title.downcase}%")
  }

  scope :sorted_by, ->(o) {
    order("created_at")
  }

end
