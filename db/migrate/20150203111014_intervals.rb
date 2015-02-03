class Intervals < ActiveRecord::Migration
  def change
  	create_table :organization do |t|
			t.integer 	 :active_time
			t.integer    :pause_time
			t.references :driver
			t.references :navigator
  		t.timestamps
  	end
  end
end
