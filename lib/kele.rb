require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    response = self.class.post(api_url + 'sessions', body: { email: "#{email}", password: "#{password}" })
    @auth_token = response["auth_token"]
    raise "ERROR: Username or password is invalid." if @auth_token.nil?
  end
  
  def get_me
    response = self.class.get(api_url + 'users/me', headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
  end

  private
  
  def api_url
    "https://www.bloc.io/api/v1/"
  end
  
end