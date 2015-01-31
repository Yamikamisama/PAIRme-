class CreateSessions < ActiveRecord::Migration
  def change
  	create_table :sessions do |t|
  		t.integer :duration
  		t.integer :downtime
  		t.integer :active
  		t.integer :user1
  		t.integer :user2
  			
  		t.timestamps
  	end 
  end
end
