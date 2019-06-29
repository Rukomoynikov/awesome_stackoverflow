class AddUserToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :user, foreign_key: { to_table: :users }
  end
end
