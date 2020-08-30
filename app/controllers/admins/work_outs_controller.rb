class Admins::WorkOutsController < ApplicationController
	before_action :authenticate_admin!

  def index
  	@ranks = User.find(WorkOut.group(:user_id).order('sum(time) desc').pluck(:user_id))
  end
end
