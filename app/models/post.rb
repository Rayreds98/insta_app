class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  validates :user_id, presence: true
  validates :content, length: {maximum: 2200}

  def thumbnail(resize, crop)
    return self.image.variant(combine_options:{resize:resize,crop:crop,gravity: :center}).processed
  end

end
