class Picture < ActiveRecord::Base
  belongs_to :user
  has_many :captions
end
