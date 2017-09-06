class HomeController < ApplicationController

  def show
  end

  def create
    puts "************* IN CREATE ************ #{params[:date]}"

    render :results
  end

end
