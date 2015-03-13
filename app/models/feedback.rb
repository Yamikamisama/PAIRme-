class Feedback < ActiveRecord::Base
  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :session

  def date_display
  	date = created_at.to_s[0..10]
  end

end
