class Artwork < ApplicationRecord
  self.per_page = 10

  store_accessor :dimensions, :width, :height, :depth

  belongs_to :artist, optional: true
  has_many :images, dependent: :destroy

  with_options presence: true do
    validates :title, :description
    validates :artist, if: -> { artist_id }
    validates :price, numericality: { greater_than: 0, less_than: 10_000_000 }
  end

  validates_each :width, :height, :depth do |record, attr, value|
    record.errors.add(attr, :blank) if value.blank?
    record.errors.add(attr, 'must be in range from 1 to 200') unless (1...200).include?(value)
  end

  state_machine :state, initial: :unpublished do
    event :publish do
      transition unpublished: :published
    end

    event :unpublish do
      transition published: :unpublished
    end
  end

  %i(width height depth).each do |met_name|
    define_method met_name do
      super().to_i
    end
  end

  def formatted_price
    sprintf('%.2f', self.price)
  end
end
