class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
        t.integer :user_id
        t.integer :listing_id
        t.string :comments
        t.date :check_in_date
        t.date :check_out_date
        t.integer :pax
        t.integer :total_price
        t.datetime :created_at
        t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
