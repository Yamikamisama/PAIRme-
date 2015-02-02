class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.references :driver_score
      t.references :navigator_score
      t.references :organization

      t.timestamps
    end
  end
end
