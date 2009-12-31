class AddContentTypeToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :content_type, :string
  end

  def self.down
    remove_column :pictures, :content_type
  end
end
