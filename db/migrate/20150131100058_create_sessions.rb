class CreateSessions < ActiveRecord::Migration
  def change
  	create_table :sessions do |t|
      t.references :feedbacks

  		t.timestamps
  	end
  end
end
