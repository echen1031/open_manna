class PlansController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_plan, only: %i[ show ]

  # GET /plans/1 or /plans/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_plan
    current_user.plan.find(params[:id])
  end
end
