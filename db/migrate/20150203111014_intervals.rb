class Intervals < ActiveRecord::Migration
  def change
  	create_table :intervals do |t|
			t.integer 	 :active_time
			t.integer    :pause_time
			t.references :driver
			t.references :navigator
			t.references :session
  		t.timestamps
  	end
  end
end
