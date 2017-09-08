class HomeController < ApplicationController

  DESCRIPTIONS = {
    earliest_calling: "earliest calling description HERE", 
    defences_due: "date defences are due to be lodged at court",
    preliminary_hearing: "date of preliminary hearing",
    final_calling: "last date summons can be called before the action falls away"
  }

  def show
  end

  def date_calculator
    @results = {}
    date = params[:date].to_date
    type = params[:type]
    court = params[:court]
    @results = {
      date: date,
      type: type,
      court: court
    }
    calculate_dates_for_action(date, type, court)
    #remove this once all data is in place
    if type == "Intellectual Property" || type == "Commercial" && court == "Court of Session"
      render :results
    else
      render :coming_soon
    end
  end

  def calculate_dates_for_action(date, type, court)
    case type
    when "Intellectual Property"
      intellectual_property(date)
    when "Commercial"
      commercial(date)  
    when "Ordinary"
      ordinary(date)
    else
      return  
    #add remaining ones here when worked out 
    end
  end

  def intellectual_property(date)
    @results[:earliest_calling] = [@results[:date] + 21.days, DESCRIPTIONS[:earliest_calling]] #nb this is based on Europe @ no earlier than 21 days - if outside Europe date is likely to be 42 days
    @results[:defences_due] = [@results[:earliest_calling][0] + 7.days, DESCRIPTIONS[:defences_due]]
    @results[:preliminary_hearing] = [@results[:defences_due][0] + 14.days, DESCRIPTIONS[:preliminary_hearing]] #within 14 days after defences or answers (as the case may be) have been lodged
    # @results[:intimate_statement_of_proposals] = @results[:preliminary_hearing] - 3.days# not less than 3 days, or such other period as may be prescribed by the judge at the preliminary hearing, before the date fixed under rule 55.2E(4) for the procedural hearing, each party shall lodge in process and send to every other party –
    @results[:final_calling] = [@results[:earliest_calling][0] + 366.days, DESCRIPTIONS[:final_calling]] #a year and a day after expirty of the period of notice so 366 + 21 = 382 days from date of service if in Europe
  end

  def commercial(date)
    puts "*******in COMMERCIAL with date as #{date}"
    @results[:earliest_calling] = @results[:date] + 21.days #nb this is based on Europe @ no earlier than 21 days - if outside Europe date is likely to be 42 days
    @results[:defences_due] = @results[:earliest_calling] + 7.days
    @results[:preliminary_hearing] = @results[:defences_due] + 14.days #within 14 days after defences or answers (as the case may be) have been lodged
    # @results[:intimate_statement_of_proposals] = @results[:preliminary_hearing] - 3.days# not less than 3 days, or such other period as may be prescribed by the judge at the preliminary hearing, before the date fixed under rule 55.2E(4) for the procedural hearing, each party shall lodge in process and send to every other party –
    @results[:final_calling] = @results[:earliest_calling] + 366.days #a year and a day after expirty of the period of notice so 366 + 21 = 382 days from date of service if in Europe
    return
  end

  def ordinary(date)
    puts "*********in ORDINARY with date as #{date}"
    render :coming_soon
  end

end
