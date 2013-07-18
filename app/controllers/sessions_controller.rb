class SessionsController < ApplicationController

  skip_before_action :current_user, only: [:log_out]

  def log_in
    current_user
  end

  def log_out
    @current_user = nil
    session[:cas_user] = nil
    RubyCAS::Filter.logout(self, root_path)
  end
end
