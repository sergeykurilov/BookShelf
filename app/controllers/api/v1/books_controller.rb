module Api
  module V1
      class BooksController < ApplicationController
        rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

        def index
          render json: Book.all
        end

        def create
          #some logic
          book = Book.create(book_params)

          if book.save
            render json: book, status: :created
          else
            render json: book.errors, status: :unprocessable_entity
          end
        end

        def destroy
          Book.find(params[:id]).destroy!
          head :no_content
        end


        def book_params
          params.require(:book).permit(:title, :author)
        end

        def not_destroyed
          render json: {}, status: :unprocessable_entity
      end
    end
  end
end