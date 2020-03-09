class BooksController < ApplicationController

  def new
    @template = Book.new
  end

  def create
    @books = Book.all
    @template = Book.new(book_params)
    @template.user_id = current_user.id
    if @template.save
      flash[:notice] = 'Book was successfully created.'
      redirect_to book_path(@template)
    else
      render 'index'
    end
  end

  def index
   @books = Book.all
   @template = Book.new
 end

 def show
   @book = Book.find(params[:id])
   @user = Book.find(params[:id]).user
   @template = Book.new
 end

 def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    else
      redirect_to books_path
    end
 end

 def update
   @book = Book.find(params[:id])
   if @book.update(book_params)
    redirect_to book_path(@book)
    flash[:notice] = 'Book was successfully updated.'
  else
    render 'edit'
  end
end

def destroy
 @book = Book.find(params[:id])
 @book.destroy
 redirect_to books_path
end

private
def book_params
 params.require(:book).permit(:title,:body)
end

def user_params
  params.require(:user).permit(:name,:introduction,:profile_image)
end
end
