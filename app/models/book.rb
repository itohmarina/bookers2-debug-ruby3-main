class Book < ApplicationRecord
  belongs_to:user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search=="perfect_match"
      @book=Book.where("title LIKE?","#{word}")
    else search=="partial_match"
      @book=Book.where("title LIKE?","%#{word}%")
    end
  end

  # スコープの名前, -> {条件式}
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } #先週

  #過去の投稿数検索、n日前の投稿数
  scope :created_days_ago, -> (n){ where(created_at: n.days.ago.all_day) }

end
