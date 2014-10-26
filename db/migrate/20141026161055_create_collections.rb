class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.string :image_url

      t.timestamps
    end
    add_index :collections, :name
  end
end
