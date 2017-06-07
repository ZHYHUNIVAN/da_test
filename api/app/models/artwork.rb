class Artwork < ApplicationRecord
  belongs_to :artist, optional: true
  has_many :images, dependent: :destroy

  with_options presence: true do
    validates :title, :description
  end

  validates :artist, presence: true, if: -> { artist_id }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 10_000_000 }

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
