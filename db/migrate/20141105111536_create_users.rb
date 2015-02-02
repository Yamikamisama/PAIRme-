class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :driver_score
      t.integer :navigator_score
      t.references :organization_members

      t.timestamps
    end
  end
end
