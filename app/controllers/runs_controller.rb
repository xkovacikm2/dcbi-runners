class RunsController < ApplicationController
  #only logged in user can manipulate runs
  before_action :authenticate_user!

  #run must be owned by user in order to be edited or destroyed
  before_action :users_run?, only: [:update, :destroy]

  def index
    @runs = current_user.runs
  end

  def create

  end

  def update

  end

  def destroy
    if @run.destroy
      flash[:notice] = t 'activerecord.messages.run_deleted'
    else
      flash[:danger] = t 'activerecord.errors.run_not_deleted'
    end
    redirect_back fallback_location: root_path
  end

  private
  def users_run?
    @run = Run.find params[:id] rescue redirect_not_found and return
    redirect_unauthorized unless @run.user == current_user
  end
end
