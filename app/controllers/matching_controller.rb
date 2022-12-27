class MatchingController < ApplicationController
  before_action :authenticate_user!

  def index
    #ログインユーザーに対してフォローしたユーザーのidを配列で取得
    #plunkで、特定カラムの情報のみ取得
    got_followers_ids=Relationships.where(followed_id: current_user.id).plunk(:follower_id)
    #上記で取得したユーザーのうち、ログインユーザーがフォローしたユーザー情報を取得し、配列を作成
    @matching_users=Relationships.where(followed_id: got_followers_ids, follower_id: current_user.id).map do |follow|
  end

end
