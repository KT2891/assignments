class BooksController < ApplicationController
  before_action :ensure_correct_book_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.new
    @show_book = Book.find(params[:id])
    @book_comment = BookComment.new
    FootStanp.create(book_id: params[:id])
  end

  def index
    today = Time.current.at_end_of_day
    week = (today - 6.day).at_end_of_day
    @books = Book.includes(:favorited_users).
              sort_by{
                      |book| -book.favorited_users.includes(:favorite).where(created_at: week...today).size }
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_book_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
