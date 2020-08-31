class Admins::WorkOutsController < ApplicationController
	before_action :authenticate_admin!

  def index
  	@ranks = User.create_all_ranks
  end
end
