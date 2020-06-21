require 'test_helper'

class ThreadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get thread_index_url
    assert_response :success
  end

end
