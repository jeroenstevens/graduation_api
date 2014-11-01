class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys, id: :uuid do |t|
      t.uuid :user_id
      t.string :access_token
      t.string :scope
      t.datetime :expires_at
      t.datetime :created_at
      t.datetime :last_access
      t.boolean :is_locked, default: false
    end
    add_index :api_keys, :access_token, unique: true
  end
end
