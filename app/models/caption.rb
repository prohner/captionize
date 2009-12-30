class Caption < ActiveRecord::Base
  belongs_to :picture
  belongs_to :user
  has_many :votes
end
