class UsersController < ApplicationController
   before_filter :signed_in_user, only: [:edit, :update, :destroy] #i.e., this only applies to edit and update.
   before_filter :correct_user,   only: [:edit, :update] 
   before_filter :signed_in_user, only: [:index, :edit, :update]
   before_filter :admin_user,     only: :destroy
 
	def show
	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
	end
	
	def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
	end
  
	def new
		@user = User.new #this goes to the class USER which is in models...you are saving to the database! which is what a model is... 
	end
  
  def create # i.e...if you go to sessions/ page...
    @user = User.new(params[:user])
    if @user.save
	  sign_in @user #this gets the session id....it is a session_helper method
	  flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #this will simply be the user name...right now you are on /users page and this just adds the /@user which is = params[:user] !
	else
      render 'new' #this renders session/new - which is just the sign in page... IT OPENS THE VIEW NEW FILE.
    end
  end
  
  def index
	@users = User.paginate(page: params[:page])
  end
  
  def edit
  end
  
    def update
    if @user.update_attributes(params[:user]) #this is just a ruby or rails methode. It takes a hash and returns TRUE if it is successful!
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user #I believe this just sends you to the /user page...
    else
      render 'edit' #if you update_attributes and it fails...the errors from the user model will appear in the view
    end
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id]) #this acutally takes the correct_user profile and sends it to both edit and update...so we do not need to call it
      redirect_to(root_path) unless current_user?(@user)
    end
	
	def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  
end
