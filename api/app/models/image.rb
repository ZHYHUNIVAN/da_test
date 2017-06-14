class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :artwork, touch: true

  validates :file, :artwork, presence: true
  validate :minimum_file_dimensions, if: -> { file.present? }

  delegate :width, :height, to: :file

  private
  def minimum_file_dimensions
    unless (file.width >= 1200 && file.height >= 800) || (file.width >= 800 && file.height >= 1200)
      errors.add :file, 'must be at least 1200x800 with 1200 on the largest side.'
    end
  end
end
