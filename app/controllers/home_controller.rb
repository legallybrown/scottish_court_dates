class HomeController < ApplicationController

  def show
  end

  def create
    puts "************* IN CREATE ************"
    render :results
  end

end
