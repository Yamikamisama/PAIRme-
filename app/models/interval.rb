class Interval < ActiveRecord::Base
 	belongs_to :driver, class_name: "User"
 	belongs_to :navigator, class_name: "User"
 	belongs_to :session
end
