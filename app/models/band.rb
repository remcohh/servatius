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

  has_many :members
  has_many :comfy_cms_sites, class_name: 'Comfy::Cms::Site', dependent: :destroy
  has_many :rehearsals
  has_many :ensembles

end
