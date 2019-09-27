class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.boolean :upvoted
      t.boolean :downvoted
      t.references :user
      t.references :voteable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
