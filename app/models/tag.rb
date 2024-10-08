class Tag < ApplicationRecord
  has_many :post_relationships, dependent: :destroy
  has_many :posts, through: :post_relationships
  validates :name, presence: true, uniqueness: true

scope :merge_posts, -> (tags){ }

  def self.search_posts_for(content, method)

    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end

    return tags.inject(init = []) {|result, tag| result + tag.books}

  end


end
