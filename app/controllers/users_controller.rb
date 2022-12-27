class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book=@books.created_today
    @yesterday_book=@books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week

    current_chat_room_user=ChatRoomUser.where(user_id: current_user.id)
    another_chat_room_user=ChatRoomUser.where(user_id: @user.id)
    unless @user.id == current_user.id
      current_chat_room_user.each do |current|
        another_chat_room_user.each do |another|
          if current.chat_room_id == another.chat_room_id
            @is_room=true
            @room_id=current.chat_room_id
          end
        end
      end
    end

  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    ensure_correct_user
  end

  def update
    ensure_correct_user
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
