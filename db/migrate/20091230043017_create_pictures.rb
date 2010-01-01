class CreatePictures < ActiveRecord::Migration
  def self.up
    drop_table :pictures
    create_table :pictures do |t|
      t.string :headline
      t.string :path_to_picture
      t.integer :user_id
      t.binary :picture_data, :limit => 1.megabyte
      t.string :content_type
      

      t.timestamps
    end

  end

  def self.down
    drop_table :pictures
  end
end
