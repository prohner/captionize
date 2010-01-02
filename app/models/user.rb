class User < ActiveRecord::Base
  has_many :pictures
  has_many :captions
  has_many :votes
  
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
  
end
