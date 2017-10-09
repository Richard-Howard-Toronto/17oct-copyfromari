require 'sinatra'
require_relative 'contact'

 get('/') do
   redirect to('/index')
 end

 get '/index' do
   @list = Contact.all
   erb :index
 end

 get '/about' do
   erb :about
 end

 get '/photos' do  #ROUTES, the url
   erb :photos
 end


 get '/delete_contact' do
   erb :delete_contact
 end

 delete '/contacts/:id' do
   @contact = Contact.find(params[:id].to_i)
   if @contact
     @contact.delete
     redirect to('/contacts')
   else
     raise Sinatra::NotFound
   end
 end




 get '/contacts/:id/edit' do
   @contact = Contact.find_by(id: params[:id].to_i)
    if @contact
        erb :edit_contact
    else
        raise Sinatra::NotFound
    end
  end




  get '/add_contact' do
    erb :add_contact
  end

  post '/add_contact' do
    Contact.create(
      first_name: params[:first_name],   #like "JANE" hash of info
      last_name: params[:last_name],   #their names become the keys and what you type is becomes the value (of the has)
      email: params[:your_email],
      note: params[:stuff_about_us],
      age: params[:ages]
    )
    redirect to('/index')
  end


  get '/contacts/:id' do
    @contact = Contact.find_by({id: params[:id].to_i})
    if @contact
      erb :show_contact
    else
      raise Sinatra::NotFound
    end

  end

  put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
      first_name: params[:first_name],   #like "JANE" hash of info
      last_name: params[:last_name],   #their names become the keys and what you type is becomes the value (of the has)
      email: params[:your_email],
      note: params[:stuff_about_us],
      age: params[:ages]
    )
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end



 after do
   ActiveRecord::Base.connection.close
 end
