class SessionsController < ApplicationController

  def new

  end

def create
  user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user # this again sets the session ID...
      redirect_back_or user #this redirects the user to the place he wanted to go...if that is edit or update. If not, it just goes to his home page! (see users controller and sessions helper)
  else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'  # this goes to the 'new' view for the sessions
  end
end

  def destroy
	sign_out
	redirect_to root_url
  end
end
