class UserSessions < ActiveRecord::Migration
  def change
  	create_table :user_sessions do |t|
  		t.references :user
  		t.references :session
  		t.timestamps
  	end
  end
end
