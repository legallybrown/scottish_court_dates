class HomeController < ApplicationController

  def show
  end

  def create
    puts "************* IN CREATE ************ #{params[:date]}"
    @results = {}
    @results[:date] = params[:date]
    puts "#{@results}"
    render :results
  end

end
