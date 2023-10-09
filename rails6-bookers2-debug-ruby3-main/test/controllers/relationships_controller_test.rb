require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get following" do
    get relationships_following_url
    assert_response :success
  end

  test "should get followers" do
    get relationships_followers_url
    assert_response :success
  end
end
