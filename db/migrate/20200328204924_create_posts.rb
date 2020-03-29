class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :author
      t.string :url
      t.string :thumbnail
      t.integer :num_comments
      t.integer :created_utc
      t.string :id_post
      t.boolean :visited

      t.timestamps
    end
  end
end
