class CreateSessions < ActiveRecord::Migration
  def change
  	create_table :sessions do |t|
  		t.integer :duration
  		t.integer :break
  		t.integer :active
  		
  		t.timestamps
  	end 
  end
end
