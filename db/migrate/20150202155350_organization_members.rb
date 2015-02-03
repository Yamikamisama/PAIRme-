class OrganizationMembers < ActiveRecord::Migration
 def change
		create_table :organization_users do |t|
			t.references :user
			t.references :organization
  		t.timestamps
  	end
  end
end
