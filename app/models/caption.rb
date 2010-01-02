class Caption < ActiveRecord::Base
  belongs_to :picture
  belongs_to :user
  has_many :votes
  
  validates_presence_of :headline, :user_id, :picture_id

  def count_of_votes_by_type(t)
    vote_count = 0
    votes.each do |v|
      if v.is_up == t
        vote_count += 1
      end
    end
    vote_count
  end

  def count_of_up_votes
    count_of_votes_by_type('y')
  end
  def count_of_down_votes
    count_of_votes_by_type('n')
  end
end
