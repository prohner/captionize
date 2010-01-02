require 'test_helper'

class CaptionTest < ActiveSupport::TestCase
  def test_invalid_with_empty_attributes
    caption = Caption.new
    assert caption.invalid?
    assert caption.errors.invalid?(:headline)
    assert caption.errors.invalid?(:picture_id)
    assert caption.errors.invalid?(:user_id)
  end

  def test_vote_count_for_captions
    caption1 = captions(:caption_pic1_1)
    assert caption1.save

    vote1 = votes(:caption1_1_upvote)
    assert vote1.save

    vote2 = votes(:caption1_2_upvote)
    assert vote2.save

    vote3 = votes(:caption1_3_downvote)
    assert vote3.save

    vote4 = votes(:caption1_4_downvote)
    assert vote4.save

    vote5 = votes(:caption1_5_downvote)
    assert vote5.save

    caption1 = Caption.find(captions(:caption_pic1_1).id)

    assert_equal 5, caption1.votes.size
    assert_equal 2, caption1.count_of_up_votes
    assert_equal 3, caption1.count_of_down_votes
  end

  def test_one_vote_per_caption_per_user
    caption_fixture = captions(:caption_pic1_1)
    vote_fixture = votes(:caption1_1_upvote)
    
    Vote.delete_all

    caption1 = caption_fixture
    assert caption1.save
    
    vote1 = vote_fixture
    vote1.is_up = 'n'
    
    assert vote1.save

    vote = Vote.get_vote_for_user_and_caption(vote_fixture.user_id, vote_fixture.caption_id)
    vote.is_up = 'y'
    assert !vote.nil?
    
    assert vote.save
    
    caption1 = Caption.find(caption_fixture.id)

    assert_equal 1, caption1.votes.size
    assert_equal 1, caption1.count_of_up_votes
    assert_equal 0, caption1.count_of_down_votes
    
  end
end
