require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/articles' do

        erb :index
    end
    get '/articles/new' do
        erb :new
    end
    post '/articles' do
        new_article = Article.create(title: params[:title],content: params[:content] )
        redirect "/articles/#{new_article.id}"
    end

    get '/articles/:id/edit' do
        @article = Article.find_by(id: params[:id])
        erb :edit
    end
    patch '/articles/:id' do
        article = Article.find_by(id: params[:id])
        title = params[:title]
        content = params[:content]
        article.update(title: title, content: content)
        redirect "/articles/#{article.id}"
    end

    delete '/articles/:id' do
        Article.destroy(params[:id])
        redirect '/'
    end

    get '/articles/:id' do
        @article = Article.find_by(id: params[:id])
        erb :show
    end
end
