class BooksController < ApplicationController


  def index
    @books = Book.all
    @users = User.all
  end

  def show
    @users = User.all
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  def edit
    @book = Book.find(params[:id])
     unless @book == current_user
      redirect_to  book_path(@book.id)
     end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body,)
  end
end
