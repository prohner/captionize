class Vote < ActiveRecord::Base
  belongs_to :caption
  belongs_to :user
end
