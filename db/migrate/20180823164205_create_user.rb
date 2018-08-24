class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :confirm_token
    end
  end
end
