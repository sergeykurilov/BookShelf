require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  controller do
    def index
      render json: {}, status: 209
    end
    def create
      render json: {books: {}}, status: 500
    end
    def destroy
      render json: {books: {}}, status: 500
    end
  end
  describe 'get books' do
    it 'returns all books' do
      FactoryBot.create(:book, title: '1925', author: 'Geador Well')
      FactoryBot.create(:book, title: '1922', author: 'Geador Peops')
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body.size).to eq(2)
    end
  end
  describe 'POST /books' do
    it 'create a new book' do
      expect {
        post :create, params: { book: {title: '1925', author: 'Geador Well'} }
      }.to change { Book.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
    it "creates a Widget and redirects to the Widget's page" do
      FactoryBot.create(:book, title: '1925', author: 'Geador Well')
      FactoryBot.create(:book, title: '1922', author: 'Geador Peops')
      get :index
      post "/api/v1/books", params: { book: {title: "My Widget", author: 'asdnaj'} }
      expect(response).to have_http_status(201)
      expect(response).to have_http_status(:success)
    end

  end
  describe 'DELETE /books/:id' do
    it 'delete a book' do
      FactoryBot.create(:book, title: '1925', author: 'Geador Well')
      delete 'http://localhost:3000/api/v1/books'
      expect(response).to have_http_status(:no_content)
    end
  end
end
describe 'Books API', type:  :request do


  describe 'get books' do
    it 'returns all books' do
      FactoryBot.create(:book, title: '1925', author: 'Geador Well')
      FactoryBot.create(:book, title: '1922', author: 'Geador Peops')
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body.size)).to eq(2)
    end
  end
  describe 'POST /books' do
    it 'create a new book' do
      expect {
        post "/api/v1/books", params: { book: {title: '1925', author: 'Geador Well'} }
      }.to change { Book.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
  end
  describe 'DELETE /books/:id' do
    it 'delete a book' do
      FactoryBot.create(:book, title: '1925', author: 'Geador Well')
      delete "/api/v1/books/1"
      expect(response).to have_http_status(:no_content)
    end
  end

end