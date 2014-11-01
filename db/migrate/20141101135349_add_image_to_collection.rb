class AddImageToCollection < ActiveRecord::Migration
  def self.up
    add_attachment :collections, :image
  end

  def self.down
    remove_attachment :collections, :image
  end
end
