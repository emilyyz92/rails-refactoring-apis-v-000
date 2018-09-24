class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github = GithubService.new
    token = github.authenticate!(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
    params[:code])
    session[:access_token] = token

    friend = GithubService.new(session)

    session[:username] = friend.get_username
    redirect_to '/'
  end
end
