class CreateFeedbacks < ActiveRecord::Migration
  def change
  	create_table :feedbacks do |t|
  		t.integer :q1
  		t.integer :q2
  		t.integer :q3
  		t.text 	  :text 
  		t.references :user
  		t.references :session

  		t.timestamps
  	end 
  end
end
