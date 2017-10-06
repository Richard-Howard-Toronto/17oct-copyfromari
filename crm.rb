require 'sinatra'
 require_relative 'contact'

 get '/' do
   redirect to('/index')
 end

 get '/about' do
     erb :about
 end

 get '/index' do
   @list = Contact.all
   erb :index
 end

  get '/add_contact' do
    erb :add_contact
  end

  post '/add_contact' do
    Contact.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      note: params[:note]
    )

    redirect to('/index')

  end


 after do
   ActiveRecord::Base.connection.close
 end
