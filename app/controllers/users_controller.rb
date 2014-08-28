require 'base64'
require 'open-uri'

class UsersController < ApplicationController 
  layout :resolve_layout
  before_action :set_user, only: [:show]
  before_filter :verify_owner, only: [:show, :image_detail]

  def new
    @user = User.new
  end

  def show
    # GET USER ID
    response = HTTParty.get("https://api.instagram.com/v1/users/search?q=#{@current_user.instagram_username}&access_token=#{SUPER_SECRET_TOKEN}")
    json = JSON.parse(response.body)

    session[:insta_id] = json["data"][0]["id"]
    session[:profile_picture] = json["data"][0]["profile_picture"]
    session[:profile_name]= json["data"][0]["full_name"]

    @results = Instagram.user_recent_media(session[:insta_id], {count: 15})  # 60 appears to be the max
  end

  def image_detail 
    # recuperation de l'URL
    img_param = params[:image]

    # création de l'url avec l'id de l'user
    img_url = "public/assets/img_uploads/#{current_user.id}.png"

    #  stock le fichier temp sur le serveur 
    open(img_url, 'wb') do |file|
       file << open(img_param).read
     end

    # Encodage en baseB4
    @img_base64 = Base64.encode64(File.open(img_url, "rb").read)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit_preferences
    respond_to do |format|
    format.html { render :edit_preferences }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to current_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private 
  
  def resolve_layout
    case action_name

    when "image_detail"
      "canvas"
    else
      "application"
    end
  end

  def set_user
  end

  def verify_owner
    if current_user.nil? 
      return redirect_to root_url
    end
    redirect_to root_url unless current_user.id != params[:id]
  end  

  def user_params
    params.require(:user).permit( :email, :instagram_username, :password, :password_confirmation, :pref_nbr)
  end
end
