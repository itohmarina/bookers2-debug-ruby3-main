class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user=User.find(@book.user_id)
    @book_comments=@book.book_comments
    @book_comment=BookComment.new

    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end

  end

  def index
    #selectでbooksテーブルを取得し、favorittes.idのカウントをfavとして、favoritesテーブルに結合し、
    #books.idが重複しているものをまとめ（一番小さいidの1件だけ表示）
    @books = Book.select('books.*', 'count(favorites.id) AS favs').left_joins(:favorites).group('books.id').order('favs desc')
    @book=Book.new
    @user=current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user=current_user
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    is_matching_login_user
  end

  def update
    @book = Book.find(params[:id])
    is_matching_login_user

    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    is_matching_login_user

    if @book.destroy
      flash[:notice]="Book was successfully destroyed"
      redirect_to books_path
    else
      render :index
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def is_matching_login_user
    user_id=@book.user_id.to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end

end
