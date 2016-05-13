class CreateTransactionTable < ActiveRecord::Migration
  def change

    create_table :transactions do |t|
      t.integer :reservation_id
    end


    add_column :reservations, :payment_made, :boolean

  end
end
