
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
      erb :new
  end

  #CREATE
  post '/articles' do
    article = Article.create(:title => params[:title], :content => params[:content])
    redirect "/articles/#{article.id}"
  end

  #READ
  get '/articles/:id' do
    @article = Article.find(params[:id])
    @title = @article.title
    @content = @article.content
    erb :show
  end

  #UPDATE
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
  erb :edit
  end

  patch '/articles/:id' do
   @article = Article.find(params[:id])
   @article.title = params[:title]
   @article.content = params[:content]
   @article.save
   redirect "/articles/#{ @article.id }"
  end

  # DELETE
  delete "/articles/:id" do
    Article.delete(params[:id])
    redirect "/articles"
  end

end
