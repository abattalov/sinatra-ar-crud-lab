
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles'
  end

  #index showing all of the articles
  get '/articles' do 
    @articles = Articles.all
    erb :index
  end

  #new articles linked to the erb :new file
  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  #creating an article based on the passed in params and redirecting user to the instance of that article ID
  get '/articles' do
    @article = Article.create(params)
    redirect to '/articles/#{@article.id}'
  end

  #showing the article based on id and linking it to the show erb file
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  #edit the article by finding it's ID and then linking it to the edit erb file
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  #update 
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to '/articles/#{@article.id}'
  end 

  #destroy
  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect to '/articles'
  end
end
