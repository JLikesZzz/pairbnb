class CreateTablesAddColumns < ActiveRecord::Migration
  def change
     add_column :users, :first_name, :string
     add_column :users, :last_name, :string
     add_column :users, :gender, :string
     add_column :users, :birthdate, :date
     add_column :users, :contact_number, :string
     add_column :users, :description, :string
     add_column :users, :country, :string
  end
end
