class OrganizationUsers < ActiveRecord::Base

  has_many :users
  has_many :organizations

end
