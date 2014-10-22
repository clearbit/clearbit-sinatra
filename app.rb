require 'sinatra'
require 'clearbit'
require 'awesome_print'
require 'erubis'

Clearbit.key = ENV['CLEARBIT_KEY']

configure do
  set :erb, escape_html: true
end

get '/' do
  erb :index
end

post '/' do
  @person = Clearbit::Streaming::Person[email: params[:email]]
  erb :index
end

__END__

@@ layout
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <%== yield %>
  </body>
  </html>

@@ index
  <form action="/" method="post">
    <input type="email" name="email" required placeholder="test@example.com">

    <button type="submit">Lookup Email</button>
  </form>

  <% if @person %>
    <hr />

    <%== @person.ai(html: true) %>

  <% end %>