class RunsController < ApplicationController
  #only logged in user can manipulate runs
  before_action :authenticate_user!

  #run must be owned by user in order to be edited or destroyed
  before_action :users_run?, only: [:update, :destroy]

  def index
    @runs = current_user.runs
    @run = Run.new
  end

  def create

  end

  def update
    if @run.update run_update_params
      render json: @run
    else
      render json: @run.errors, status: :unprocessable_entity
    end
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

  def run_update_params
    pars = params.to_unsafe_hash
    pars[:name] = pars[:name].tr '^[a-zA-Z_]', ''
    rv = {}
    if %w(duration date distance).include? pars[:name]
      rv[pars[:name]] = pars[:value]
    end
    rv
  end
end
