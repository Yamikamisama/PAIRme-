class CreateSessions < ActiveRecord::Migration
  def change
  	create_table :sessions do |t|
  		t.integer :duration
  		t.integer :pause_time
  		t.integer :work_time
  		t.integer :user1_drive_time
  		t.integer :user2_drive_time
      t.references :user1
      t.references :user2

  		t.timestamps
  	end
  end
end
