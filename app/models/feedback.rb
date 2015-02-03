class Feedback < ActiveRecord::Base
  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :session


  # def average(array)
  # 	all_ratings = array
  #   all_ratings.reduce(:+) / all_ratings.length
  # end

  # def driver_score
  #   rating1
  # end

  # def navigator_score
  #   rating2
  # end

  # def overall_score
  #   rating3
  # end
end
