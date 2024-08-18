class Post < ApplicationRecord

  has_many   :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
   has_many :post_relationships, dependent: :destroy
   has_many :tags, through: :post_relationships


# 画像取得
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

# いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

# タグ機能
  def save_tags(savearticle_tags)
    savearticle_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
      self.tags << post_tag
    end
  end

# 検索機能
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('name LIKE ?', '%' + content)
    else
      Post.where('name LIKE ?', '%' + content + '%')
    end
  end

  def deletable_by?(user)
       user && (user.admin? || user.id == self.user_id)
  end

end
