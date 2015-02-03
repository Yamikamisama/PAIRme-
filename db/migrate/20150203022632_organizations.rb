class Organizations < ActiveRecord::Migration
  def change
  	create_table :organization do |t|
			t.text :name
  		t.timestamps
  	end
  end
end
