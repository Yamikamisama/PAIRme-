class CreateSessions < ActiveRecord::Migration
  def change
  	create_table :sessions do |t|
      t.references :feedbacks
      t.references :intervals

  		t.timestamps
  	end
  end
end
