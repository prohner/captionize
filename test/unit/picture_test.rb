require 'test/test_helper'

class PictureTest < ActiveSupport::TestCase
  fixtures :pictures
  fixtures :captions

  def test_invalid_with_empty_attributes
    picture = Picture.new
    assert picture.invalid?
    assert picture.errors.invalid?(:headline)
    assert picture.errors.invalid?(:path_to_picture)
    assert picture.errors.invalid?(:user_id)
    assert picture.errors.invalid?(:content_type)
  end
  
  def test_valid_user_id
    picture = Picture.create(:headline => 'Preston\'s favorite picture',
                             :path_to_picture => 'uploads/rails.png',
                             :content_type => 'image')
    assert picture.invalid?
    assert picture.errors.invalid?(:user_id)

    picture.user_id = users(:preston).id
    assert picture.save
  end
  
  def test_valid_content_type
    picture = Picture.create(:headline => 'Preston\'s favorite picture',
                             :path_to_picture => 'uploads/rails.png',
                             :content_type => 'image')
    picture.user_id = users(:preston).id
    assert picture.valid?
    
    picture.content_type = 'whatever'
    assert picture.invalid?
  end
  
  def test_caption_count_for_pictures
    picture = Picture.create(:headline => pictures(:picture1).headline,
                             :path_to_picture => pictures(:picture1).path_to_picture,
                             :content_type => pictures(:picture1).content_type,
                             :user_id => pictures(:picture1).user_id)
    assert !picture.nil?
    
    assert picture.save

    caption1 = captions(:caption_pic1_1)
    picture.captions << caption1
    
    caption2 = captions(:caption_pic1_2)
    picture.captions << caption2
    
    assert picture.save

    assert_equal 2, picture.captions.size
  end
end
