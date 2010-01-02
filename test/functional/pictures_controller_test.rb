require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pictures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  #test "should create picture" do
  #  assert_difference('Picture.count') do
  #    post :create, :picture => { }
  #  end
  #
  #  assert_redirected_to picture_path(assigns(:picture))
  #end

  test "should show picture" do
    get :show, :id => pictures(:picture1).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pictures(:picture1).to_param
    assert_response :success
  end

  test "should update picture" do
    put :update, :id => pictures(:picture1).to_param, :picture => { }
    assert_redirected_to picture_path(assigns(:picture))
  end

  test "should destroy picture" do
    assert_difference('Picture.count', -1) do
      delete :destroy, :id => pictures(:picture1).to_param
    end

    assert_redirected_to pictures_path
  end
  
  test "should add new caption" do
    assert_difference('Caption.count', 1) do
      caption_id = "new_caption_%d" % pictures(:picture1).id
      get :add_caption, caption_id => 'Hi, new caption', :picture_id => pictures(:picture1).to_param
    end
    assert_response :success
  end
  
  test "should add vote" do
    Vote.delete_all
    assert_difference('Vote.count', 1) do
      
      get :caption_vote, :id => captions(:caption_pic1_1).to_param, :u => 'y'
    end
    assert_response :success
  end
  
end
