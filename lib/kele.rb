require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
  include HTTParty
  include Roadmap
  base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    response = self.class.post(api_url + 'sessions', body: { email: '#{email}', "password": "#{password}" })
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

  def get_messages(page)
    if page == nil
      response = self.class.get(api_url + 'message_threads', headers: { "authorization" => @auth_token })
    else
      response = self.class.get(api_url + 'message_threads?page=' + '#{page}', headers: { "authorization" => @auth_token })
    end
    @messages = JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token, subject, stripped_text)
    response = self.class.post(api_url + 'messages', body: { sender: "#{sender}", recipient_id: "#{recipient_id}", token: "#{token}", subject: "#{subject}", stripped_text: "#{stripped_text}" }, headers: { "authorization" => @auth_token, "content_type" => application/json })
    @message = JSON.parse(response.body)
  end
  
  private
  
  def api_url
    "https://www.bloc.io/api/v1/"
  end
  
end