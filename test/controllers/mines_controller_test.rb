require "test_helper"

class MinesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mines_new_url
    assert_response :success
  end

  test "should get create" do
    get mines_create_url
    assert_response :success
  end

  test "should get edit" do
    get mines_edit_url
    assert_response :success
  end

  test "should get update" do
    get mines_update_url
    assert_response :success
  end
end
