class CreateSessions < ActiveRecord::Migration
  def change
  	create_table :sessions do |t|
  		t.integer :duration
  		t.integer :downtime
  		t.integer :active
  		t.references :user
  		
  		t.timestamps
  	end 
  end
end
