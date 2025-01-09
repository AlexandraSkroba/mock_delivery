class CreateDeliveries < ActiveRecord::Migration[8.0]
  def change
    create_table :deliveries do |t|
      t.string :state, null: false, default: "preparation"
      t.integer :book_id, null: false

      t.timestamps
    end
  end
end
