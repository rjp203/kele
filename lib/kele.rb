require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  
  def initialize(username, password)
    response = self.class.post('/sessions', body: { username: "#{username}", password: "#{password}" } )
    @auth_token = response["auth_token"]
    raise "ERROR: Username or password is invalid." if @auth_token.nil?
  end
  
  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
  end
  
end