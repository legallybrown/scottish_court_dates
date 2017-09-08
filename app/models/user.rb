class User < ActiveRecord::Base
  serialize :data

  def has_email?
    self.email.length > 0
  end

  def search_results
    self.data
  end


  private

  def user_params
    params.require(:email).permit(:name, :data, :company_name)
  end

end
