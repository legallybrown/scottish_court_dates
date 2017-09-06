class HomeController < ApplicationController

  def show
  end

  def create
    @results = {}
    @results[:date] = params[:date]
    puts "#{@results}"
    render :results
  end

end
