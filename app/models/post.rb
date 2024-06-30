class Post < ApplicationRecord
  # gem:acts_as_taggableの使用
  has_many   :posts, dependent: :destroy
  has_many   :comments, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_one_attached :image
  acts_as_taggable_on :tags

end
