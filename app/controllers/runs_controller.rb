class RunsController < ApplicationController
  #only logged in user can manipulate runs
  before_action :authenticate_user!

  #run must be owned by user in order to be edited or destroyed
  before_action :users_run?, only: [:edit, :destroy]

  def index
    @runs = current_user.runs
  end

  def create

  end

  def edit

  end

  def destroy

  end

  private
  def users_run?
    @run = Run.find id: params[:id] rescue RecordNotFound redirect_not_found and return
    redirect_unauthorized unless @run.user == current_user
  end
end
