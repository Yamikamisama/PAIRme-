class OrganizationUsers < ActiveRecord::Migration
  def change
		create_table :organization_users do |t|
			t.references :user
			t.references :organization
  		t.timestamps
  	end
  end
end
