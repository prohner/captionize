class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :headline
      t.string :path_to_picture
      t.integer :user_id

      t.timestamps
    end

    add_column :pictures, :picture_data, :binary, :limit => 1.megabyte
    add_column :pictures, :content_type, :string
  end

  def self.down
    drop_table :pictures
  end
end
