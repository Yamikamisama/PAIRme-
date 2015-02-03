class CreateFeedbacks < ActiveRecord::Migration
  def change
  	create_table :feedbacks do |t|
  		t.integer :q1
  		t.integer :q2
  		t.integer :q3
  		t.text 	  :content
      t.timestamps

      t.references :receiver
      t.references :giver
  		t.references :session
  	end
  end
end
