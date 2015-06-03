class Todo < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :body , default: "N/A", limit: 300
      t.boolean :completed , default: false
    end
  end
end
