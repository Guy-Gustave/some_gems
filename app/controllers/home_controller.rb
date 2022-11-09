class HomeController < ApplicationController
  def index
    @courses = Course.all.limit(4)
    @latest_couses = Course.all.limit(2).order(created_at: :desc)
  end

  def index
    @activities = PublicActivity::Activity.all
  end
  
end
