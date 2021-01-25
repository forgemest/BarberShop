require 'rubygems'
require 'sinatra'
# require 'sinatra/reloader'

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

  # if @username == ''
  #   @error = 'Введите Имя'
  # end
  #
  # if @phone == ''
  #   @error = 'Введите номер телефона'
  # end
  #
  # if @datetime == ''
  #   @error = 'Неправильная дата и время'
  # end
  #
  # if @error != ''
  #   return  erb :visit
  #
  # end

  hh = {:username => 'Введите Имя',
        :phone => 'Введите номер телефона',
        :datetime => 'Неправильная дата и время', }
  @error = hh.select {|key,_| params[key] == ""}.values.join(", ")
  if @error != ''
      return  erb :visit
  end

  erb "ok, username is #{@username}, #{@phone}, #{@pdatetime}, #{@barber}, #{@color}"
end


get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @name = params[:name]
  @mail = params[:mail]
  @body = params[:body]

    # require 'pony'
    # Pony.mail(
    #     :name => params[:name],
    #     :mail => params[:mail],
    #     :body => params[:body],
    #     :to => 'forgemest@gmail.com',
    #     :subject => params[:name] + " has contacted you",
    #     :body => params[:message],
    #     :port => '587',
    #     :via => :smtp,
    #     :via_options => {
    #         :address              => 'smtp.gmail.com',
    #         :port                 => '587',
    #         :enable_starttls_auto => true,
    #         :user_name            => 'lumbee',
    #         :password             => 'p@55w0rd',
    #         :authentication       => :plain,
    #         :domain               => 'localhost.localdomain'
    #     })
    # redirect '/success'


  # Вывод ошибки
  hhh = {:email => 'Введите почту',
        :text => 'Введите текст'}

  @error = hhh.select {|key,_| params[key] == ""}.values.join(", ")
  if @error != ''
    return  erb :contacts
  end

  erb "Спасибо за отзыв. Мы отправим ответ на вашу почту #{@mail}"
end
