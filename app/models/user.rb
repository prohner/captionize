class User < ActiveRecord::Base
  has_many :pictures
  has_many :captions
  has_many :votes
end
