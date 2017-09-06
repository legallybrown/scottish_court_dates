class HomeController < ApplicationController

  def show
  end

  def date_calculator
    @results = {}
    @results[:date] = params[:date]
    puts "#{params}"
    @results[:court] = params[:court]
    @results[:type] = params[:type]
    render :results
  end

end
