class ChargesController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
  end

  def create
  end
end
