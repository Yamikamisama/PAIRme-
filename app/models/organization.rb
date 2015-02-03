class Organization < ActiveRecord::Base
	has_many :organization_members
	has_many :users, through: :organization_members
end
