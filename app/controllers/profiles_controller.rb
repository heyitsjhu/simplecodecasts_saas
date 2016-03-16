class ProfilesController < ApplicationController
  before_action :authenticate_user! #Devise gem feature to verify that the user has the authorization to access user profiles
  before_action :only_current_user #defined below
  
  def new
    # form where a user can fill out their own profile.
    @user = User.find( params[:user_id] )
    @profile = Profile.new
  end
  
  def create
    @user = User.find( params[:user_id] ) # grabs user_id from the url form, as set up using Devise's current_user in the pages' new.html.erb page
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  def edit
    @user = User.find( params[:user_id] )  
    @profile = @user.profile
  end
  
  def update
    @user = User.find( params[:user_id] ) # grabs user_id from the url form, as set up using Devise's current_user in the pages' new.html.erb page
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      flash[:warning] = "Something went wrong! Please try again."
      render action: :edit
    end
  end
  
  private
  
    def profile_params 
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description, :avatar)  
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end