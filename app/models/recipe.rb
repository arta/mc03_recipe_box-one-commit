class Recipe < ApplicationRecord
  belongs_to :user
  # fix error message: "<Recipe ingredient> must exist"
  # https://www.sitepoint.com/better-nested-attributes-in-rails-with-the-cocoon-gem/
  has_many :ingredients, dependent: :destroy, inverse_of: :recipe
  has_many :directions, dependent: :destroy, inverse_of: :recipe

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true

  has_attached_file :image, styles: { medium: "300x300#" }#, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :title, :description, presence: true
  validates :image, presence: true, on: :create
end
