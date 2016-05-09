class AddColumnRemoveColumn < ActiveRecord::Migration
  def change
    rename_column :listings, :host_id, :user_id
  end
end
