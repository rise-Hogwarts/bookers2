class BooksController < ApplicationController


  def index
    @books = Book.all
    @users = User.all
    @book = Book.new
  end

  def show
    @users = User.all
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @users = User.all
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  def edit
    @book = Book.find(params[:id])
     unless @book.user == current_user
      redirect_to  books_path
     end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'You have updated book successfully.'
       redirect_to book_path(@book.id)
    else
       render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :profile_image, :body,)
  end
end
