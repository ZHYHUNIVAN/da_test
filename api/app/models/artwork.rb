class Artwork < ApplicationRecord
  self.per_page = 10

  store_accessor :dimensions, :width, :height, :depth

  belongs_to :artist
  has_many :images, dependent: :destroy

  with_options presence: true do
    validates :artist
    validates :title, :description
    validates :artist, if: -> { artist_id }
    validates :price, numericality: { greater_than: 0, less_than: 10_000_000 }
  end

  validates_each :width, :height, :depth do |record, attr, value|
    record.errors.add(attr, :blank) if value.blank?
    record.errors.add(attr,:not_a_number) if value =~ /\A\d+\z/ ? false : true
  end

  state_machine :state, initial: :unpublished do
    event :publish do
      transition unpublished: :published
    end

    event :unpublish do
      transition published: :unpublished
    end
  end

  def formatted_price
    sprintf('%.2f', self.price)
  end
end
