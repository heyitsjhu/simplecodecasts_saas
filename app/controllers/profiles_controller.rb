class ProfilesController < ApplicationController
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
  
  private
  
    def profile_params 
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)  
    end
end