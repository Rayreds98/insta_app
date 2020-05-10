class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :keeps, dependent: :destroy
  has_many :keep_users, through: :keeps, source: :user
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: :user

  validates :user_id, presence: true
  validates :content, length: {maximum: 2200}

  scope :posts_all, -> {
    select(:id, :content, :user_id, :created_at).order('created_at desc').includes(:user)
  }

  def thumbnail(resize, crop)
    return self.image.variant(combine_options:{resize:resize,crop:crop,gravity: :center}).processed
  end

end
