class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id, null: false, limit: 5
      t.integer :implement, null: false, default: 3000
      t.integer :progress, null: false, default: 0
      t.string :target
      t.datetime :date_from
      t.datetime :date_to
      t.boolean :favorite_empty, null: false, default: false
      t.boolean :request_many, null: false, default: false
      t.boolean :cancelled, null: false, default: false

      t.timestamps null: false
    end
    add_index :tasks, :user_id
  end
end
