class Vote < ActiveRecord::Base
  belongs_to :caption
  belongs_to :user

  def self.get_vote_for_user_and_caption(user_id, caption_id)
    @vote = Vote.find(:first, :conditions => ["votes.user_id = ? and votes.caption_id = ?", user_id, caption_id])
    if @vote.nil?
      @vote = Vote.create(:user_id => user_id, :caption_id =>  caption_id)
    end
    @vote
  end

end
