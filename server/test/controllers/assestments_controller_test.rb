require "test_helper"

class AssestmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assestment = assestments(:one)
  end

  test "should get index" do
    get assestments_url
    assert_response :success
  end

  test "should get new" do
    get new_assestment_url
    assert_response :success
  end

  test "should create assestment" do
    assert_difference("Assestment.count") do
      post assestments_url, params: { assestment: {  } }
    end

    assert_redirected_to assestment_url(Assestment.last)
  end

  test "should show assestment" do
    get assestment_url(@assestment)
    assert_response :success
  end

  test "should get edit" do
    get edit_assestment_url(@assestment)
    assert_response :success
  end

  test "should update assestment" do
    patch assestment_url(@assestment), params: { assestment: {  } }
    assert_redirected_to assestment_url(@assestment)
  end

  test "should destroy assestment" do
    assert_difference("Assestment.count", -1) do
      delete assestment_url(@assestment)
    end

    assert_redirected_to assestments_url
  end
end
