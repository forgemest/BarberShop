require 'rubygems'
require 'sinatra'
require 'sqlite3'

def get_db
  db = SQLite3::Database.new 'barbershop.db'
  db.results_as_hash = true
  return db
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS
  "Users"
  (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "username" TEXT,
      "phone" TEXT,
      "datestamp" TEXT,
      "barber" TEXT,
      "color" TEXT
  )'
end

get '/' do
  erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do
  @error = 'Something wrong!'
  erb :about
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color = params[:color]

  hh = {:username => 'Введите Имя',
        :phone => 'Введите номер телефона',
        :datetime => 'Неправильная дата и время', }
  @error = hh.select {|key,_| params[key] == ""}.values.join(", ")
  if @error != ''
    return  erb :visit
  end

  db = get_db
  db.execute 'insert into
  Users
  (
    username,
    phone,
    datestamp,
    barber,
    color
  )
  values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]

  erb "ok, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @name = params[:name]
  @mail = params[:mail]
  @body = params[:body]
  # Вывод ошибки
  hhh = {:email => 'Введите почту',
        :text => 'Введите текст'}
  @error = hhh.select {|key,_| params[key] == ""}.values.join(", ")
  if @error != ''
    return  erb :contacts
  end
  erb "Спасибо за отзыв. Мы отправим ответ на вашу почту #{@mail}"
end


