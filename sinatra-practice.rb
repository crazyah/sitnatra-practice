require 'sinatra'
require 'sinatra/reloader' if development?
enable :sessions


get '/' do
  erb :index, layout: :header_footer
end

get '/atm' do 
  if session[:amount] == nil 
    session[:amount] = 0
  end

  erb :atm , layout: :header_footer 
end

post '/atm' do

  plus_minus = params[:plus_minus]
  plus_minus_number = params[:plus_minus_number].to_i

  if plus_minus == "plus" and plus_minus_number >= 0
    session[:amount] = session[:amount] + plus_minus_number
  
  elsif plus_minus == "minus" && plus_minus_number >= 0 && session[:amount] >= plus_minus_number

    session[:amount] = session[:amount] - plus_minus_number
  end
@plus_minus_number = plus_minus_number

redirect "/atm"
end

get "/clear" do
  session[:amount] = nil
  redirect "/atm"
end

