ENV["RACK_ENV"] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :sessions_secret, 'super secret'

  get '/' do
   "YO"
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  get '/links/new' do
    erb :links_new
  end

  post '/links' do
    tag_name_array = params[:tag_name].split(";")
    link = Link.create(url: params[:url], title: params[:title])
    tag_name_array.each do |tag_name|
      tag = Tag.first_or_create(tag_name: tag_name)
      link.tags << tag
      link.save
    end
    redirect '/links'
  end

  get '/tags/:tag_name' do
    @links = Link.all.select do |link|
      link.tags.map(&:tag_name).include?(params[:tag_name])
    end
    erb :links
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    user = User.create(email: params[:email], password: params[:password])
    session[:current_user_id] = user.id
    session[:first_session] = true
    redirect '/links'
  end

  run! if app_file == $0
end
