require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
  include HTTParty
  include Roadmap
  base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    response = self.class.post(api_url + 'sessions', body: { email: "#{email}", password: "#{password}" })
    @auth_token = response["auth_token"]
    raise "ERROR: Username or password is invalid." if @auth_token.nil?
  end
  
  def get_me
    response = self.class.get(api_url + 'users/me', headers: { "authorization" => @auth_token })
    @user = JSON.parse(response.body)
  end
  
  def get_mentor_availability(mentor_id)
    response = self.class.get(api_url + '/mentors/#{mentor_id}/student_availability', headers: {"authorization" => @auth_token })
    @mentor = JSON.parse(response.body)
  end

  private
  
  def api_url
    "https://www.bloc.io/api/v1/"
  end
  
end