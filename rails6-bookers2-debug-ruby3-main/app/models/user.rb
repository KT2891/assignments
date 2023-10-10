class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォロー機能用のアソシエーション
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: "active_relationships", source: :followed
  has_many :followers, through: "passive_relationships", source: :follower

  # DM機能用のアソシエーション
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def followed_by?(user)
    following.include?(user)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @users = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @users = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @users = User.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @users = User.where("name LIKE?", "%#{word}%")
    else
      @users = User.all
    end
  end

end
