class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :user_id, presence: true
  validates :content, length: {maximum: 2200}

  def thumbnail
    return self.image.variant(combine_options:{resize:"320x320^",crop:"320x320+0+0",gravity: :center}).processed
  end
end
