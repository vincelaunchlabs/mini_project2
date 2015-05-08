class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :caption
      t.text :description
      t.int :user_id
      t.boolean :is_draft
      t.boolean :is_archived

      t.timestamps null: false
    end
  end
end
