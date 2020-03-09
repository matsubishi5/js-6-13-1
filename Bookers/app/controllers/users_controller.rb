class UsersController < ApplicationController

	def new
		@template = Book.new
	end

	def create
		@book = Book.all
		@template = Book.new(book_params)
		@template.user_id = current_user.id
		if  @template.save
			redirect_to book_path(@template)
			flash[:notice] = "Book was successfully created."
		else
			render 'books/index'
		end
	end

	def index
		@users = User.all
		@template = Book.new
	end

	def show
		@user = User.find(params[:id])
		@books = @user.books
		@template = Book.new
	end

	def edit
		@user = User.find(params[:id])
	    if @user == current_user
	    else
	      redirect_to user_path(current_user)
	    end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user)
			flash[:notice] = "User was successfully updated."
		else
			render 'edit'
		end
	end

	private
	def user_params
		params.require(:user).permit(:name,:introduction,:profile_image)
	end

	def book_params
		params.require(:book).permit(:title,:body)
	end
end
