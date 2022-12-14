class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #フォロワーを参照しにいく
  has_many :relationships, class_name: "Relationship", foreign_key:"follower_id", dependent: :destroy
  #フォロー先を参照しにいく
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key:"followed_id", dependent: :destroy
  #一覧画面で使う
  #フォロー先を参照しにいく
  has_many :followings, through: :relationships, source: :followed
  #フォロワーを参照しにいく
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  
  has_many :chat_room_users, foreign_key:"user_id", dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages, foreign_key:"user_id"
  
  has_many :view_counts, dependent: :destroy


  validates :name, presence:true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length:{maximum:50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def self.looks(search, word)
    if search=="perfect_match"
      @user=User.where("name LIKE?","#{word}")
    else search=="partial_match"
      @user=User.where("name LIKE?","%#{word}%")
    end
  end


end
