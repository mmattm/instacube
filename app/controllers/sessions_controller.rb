class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      #redirect_to :User, :notice => "Logged in!"
      redirect_to user
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:profile_picture] = nil
    session[:profile_name] = nil
    session[:insta_id] = nil
    #reset_session
    redirect_to root_url, :notice => "Logged out!"
  end
end
