class CreateCaptions < ActiveRecord::Migration
  def self.up
    create_table :captions do |t|
      t.string :headline
      t.integer :user_id
      t.integer :picture_id

      t.timestamps
    end
  end

  def self.down
    drop_table :captions
  end
end
