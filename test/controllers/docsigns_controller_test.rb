require 'test_helper'

class DocsignsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get docsigns_index_url
    assert_response :success
  end

end
