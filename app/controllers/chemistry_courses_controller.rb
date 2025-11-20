class ChemistryCoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # List all chemistry courses
    @courses = Course.where("slug LIKE ?", "%chemistry%").published.ordered
  end

  def show
    @course = Course.find_by!(slug: params[:slug])
    # Render the React-based course viewer
  end
end
