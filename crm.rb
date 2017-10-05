require 'sinatra'
 require_relative 'contact'

 get '/' do
   redirect to('/index')
 end

 get '/about' do
     erb :about
 end

 get '/contacts' do
   @list = Contact.all
   erb :contacts
 end



 get '/index' do
   erb :index
 end




 after do
   ActiveRecord::Base.connection.close
 end
