class BooksController < ApplicationController
  def new
    @books = Book.new
  end
  
  def create
    
    @books = Book.all
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "Book was successfully created"
     redirect_to book_path(@new_book)
    else
     render :index
    end
    
  end

  def index
    @books = Book.all
    @new_book = Book.new
    
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
   
  end
  
  def destroy
    book = Book.find(params[:id])  
    book.destroy  
    redirect_to '/books'  
    flash[:notice] = "Book was successfully destroy" 
  end
  
  def update
    @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
     redirect_to book_path(@book.id)
  else
     render :edit
  end

  end
 private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
