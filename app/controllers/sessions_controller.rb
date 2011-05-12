class SessionsController < ApplicationController
  def new
  end

  def create
    options = {:type_id => "email", :id_value => params[:identifier], :password => params[:password]}
    self.current_user = Zavers.consumer_authenticate(options)
    redirect_to root_path, :notice => "Logged in #{current_user.first_name} Successfully"
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "Logged Out Successfully"
  end
end

