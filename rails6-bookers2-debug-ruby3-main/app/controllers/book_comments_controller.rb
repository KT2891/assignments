class BookCommentsController < ApplicationController
  before_action :ensure_corrent_user, only: [:destroy]

  def create

    book = Book.find(params[:book_id])
    comment = book.book_comments.new(book_comment_params)
    comment.user_id = current_user.id
    comment.save
    flash[:notice] = "Your comment was successfully posted."
    redirect_to book_path(book)

  end

  def destroy
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.find_by(book_id: book.id)
    comment.destroy
    redirect_to book_path(book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


  def ensure_corrent_user
    comment = BookComment.find(params[:id])
    if comment.user.id =! current_user.id
      redirect_to book_path(book_id)
    end
  end
end
