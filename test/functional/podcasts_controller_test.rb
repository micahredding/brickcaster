require 'test_helper'

class PodcastsControllerTest < ActionController::TestCase
  setup do
    @podcast = podcasts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:podcasts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create podcast" do
    assert_difference('Podcast.count') do
      post :create, podcast: { art_url: @podcast.art_url, body: @podcast.body, links: @podcast.links, title: @podcast.title }
    end

    assert_redirected_to podcast_path(assigns(:podcast))
  end

  test "should show podcast" do
    get :show, id: @podcast
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @podcast
    assert_response :success
  end

  test "should update podcast" do
    put :update, id: @podcast, podcast: { art_url: @podcast.art_url, body: @podcast.body, links: @podcast.links, title: @podcast.title }
    assert_redirected_to podcast_path(assigns(:podcast))
  end

  test "should destroy podcast" do
    assert_difference('Podcast.count', -1) do
      delete :destroy, id: @podcast
    end

    assert_redirected_to podcasts_path
  end
end
