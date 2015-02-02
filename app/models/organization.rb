class Organization < ActiveRecord::Base

  has_many :users through: :organization_users

end
