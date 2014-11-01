class CreateItems < ActiveRecord::Migration
  def change
    create_table :items, id: :uuid do |t|
      t.string :name
      t.string :image_url
      t.integer :collection_id

      t.timestamps
    end
    add_index :items, :collection_id
  end
end
