class SessionsController < ApplicationController

  def log_in
    RubyCAS::Filter
    current_user
    redirect_to root_path
  end

  def log_out
    @current_user = nil
    session[:cas_user] = nil
    RubyCAS::Filter.logout(self, root_path)
  end

  def current_user(redirect=true)
    @user = User.where(netid: session[:cas_user]).first
    redirect && !params[:delete]
    redirect_to new_user_path and return
  end

end
