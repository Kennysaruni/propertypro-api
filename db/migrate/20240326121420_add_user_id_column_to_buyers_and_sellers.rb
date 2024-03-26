class AddUserIdColumnToBuyersAndSellers < ActiveRecord::Migration[7.1]
  def change
    add_column :owners, :user_id, :integer
    add_column :tenants, :user_id, :integer
  end
end
