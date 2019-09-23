class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :_type
      t.integer :upvotes
      t.integer :downvotes
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
