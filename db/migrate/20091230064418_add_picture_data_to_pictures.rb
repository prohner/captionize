class AddPictureDataToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :picture_data, :binary, :limit => 1.megabyte
  end

  def self.down
    remove_column :pictures, :picture_data
  end
end
