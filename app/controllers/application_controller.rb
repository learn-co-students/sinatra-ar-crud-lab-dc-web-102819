
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  set :method_override , true 

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/article/new' do
    erb :new
  end

  post '/article' do 
    title = params[:title]
    content = params[:content]
    @article= Article.create(:title => title, :content => content)
    redirect to "/article/#{@article.id}"
  end 


  get '/article/:id' do
   article_id  = params[:id]
    @article = Article.find(article_id)
    erb :show
  end


 get '/article/:id/edit' do 
  article_id = params[:id]
  @article = Article.find(article_id)
  erb :edit 
  end 

   patch '/article/:id' do 
    article_id = params[:id]
    @article = Article.find(article_id)
    @title = params[:title]
    @content = params[:content]
    @article.update(title:@title , content:@content) 
    redirect "/article/#{@article.id}"
   end 


   delete '/article/:id' do 
      @article = Article.find(params[:id])
      @article.delete
      redirect "/articles"
    end 
end 
