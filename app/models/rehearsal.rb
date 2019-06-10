class Rehearsal < ApplicationRecord
  filterrific(
      default_filter_params: { sorted_by: 'date_time asc' },
      available_filters: [
          :sorted_by
      ],
  )

  scope :sorted_by, ->(o) {
    order("date_time asc")
  }

  belongs_to :band
end
