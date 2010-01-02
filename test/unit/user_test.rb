require 'test/test_helper'

class UserTest < ActiveSupport::TestCase
  
  fixtures :users
  
  def test_invalid_with_empty_attributes
    user = User.new
    assert user.invalid?
    assert user.errors.invalid?(:name)
    assert user.errors.invalid?(:email)
  end
  
  def test_only_unique_names_are_valid
    user = User.create(:name => users(:preston).name, :email => "bogus+email")
    assert !user.save
  end

  def test_only_unique_emails_are_valid
    user = User.create(:name => "bogus+name", :email => users(:preston).email)
    assert !user.save
  end

end
