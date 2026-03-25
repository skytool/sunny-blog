class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy

  has_one_attached :cover_image
  has_many_attached :photos

  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :content, presence: true
end
