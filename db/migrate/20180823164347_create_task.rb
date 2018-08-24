class CreateTask < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.boolean :done, default: false
      t.datetime :duedate
      t.integer :priority
    end
    add_reference :tasks, :user, index: true
  end
end
