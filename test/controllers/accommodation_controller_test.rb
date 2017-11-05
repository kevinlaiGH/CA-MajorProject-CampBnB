require 'test_helper'

class AccommodationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get accommodation_index_url
    assert_response :success
  end

  test "should get new" do
    get accommodation_new_url
    assert_response :success
  end

  test "should get create" do
    get accommodation_create_url
    assert_response :success
  end

  test "should get listing" do
    get accommodation_listing_url
    assert_response :success
  end

  test "should get pricing" do
    get accommodation_pricing_url
    assert_response :success
  end

  test "should get description" do
    get accommodation_description_url
    assert_response :success
  end

  test "should get photo_upload" do
    get accommodation_photo_upload_url
    assert_response :success
  end

  test "should get amenities" do
    get accommodation_amenities_url
    assert_response :success
  end

  test "should get location" do
    get accommodation_location_url
    assert_response :success
  end

  test "should get update" do
    get accommodation_update_url
    assert_response :success
  end

end
