class AddParentIdToComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :parent, null: true
  end
end
