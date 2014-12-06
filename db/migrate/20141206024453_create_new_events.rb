class CreateNewEvents < ActiveRecord::Migration
  def change
    create_table :new_events do |t|
      t.integer :count
    end
  end
end
