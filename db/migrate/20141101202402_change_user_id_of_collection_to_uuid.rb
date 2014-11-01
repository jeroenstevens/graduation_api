class ChangeUserIdOfCollectionToUuid < ActiveRecord::Migration
  def up
    change_table :collections do |t|
      t.change :user_id, :uuid
    end
  end

  def down
    change_table :collections do |t|
      t.change :user_id, :integer
    end
  end
end
