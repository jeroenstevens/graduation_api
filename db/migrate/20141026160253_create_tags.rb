class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, id: :uuid do |t|
      t.string :name
      t.integer :user_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :tags, :user_id
    add_index :tags, :tag_id
  end
end
