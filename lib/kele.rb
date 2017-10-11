require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  
  def initialize(u, p)
    @auth = {username: u, password: p}
    self.class.post('https://www.bloc.io/api/v1/sessions')
  end
  
end