class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @user = User.find(params[:id])
     unless @user == current_user
      redirect_to  user_path(current_user.id)
     end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:success] = 'You have updated user successfully.'
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
