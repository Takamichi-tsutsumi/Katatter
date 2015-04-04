class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash[:error] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    #user = current_user
    sign_out
    redirect_to root_url
  end
end
