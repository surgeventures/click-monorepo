# frozen_string_literal: true

require "test_helper"

class HomePageTest < Minitest::Test
  def setup
    @driver = WebDrivers.default
    @home_page = HomePage.new(@driver)
  end

  def teardown
    @driver.quit
  end

  def test_can_open_via_url
    @home_page.open_via_url
    @home_page.save_screenshot(:open_via_url)

    assert_match(
      /The most sophisticated click counter ever/,
      @home_page.p_lead.text,
      "Home page did not open via URL"
    )
  end

  def test_can_see_click_count
    @home_page.open_via_url

    assert_match(
      /\d+/,
      @home_page.button_click_count.text,
      "Click count not present"
    )
  end

  def test_can_add_clicks
    @home_page.open_via_url
    @home_page.save_screenshot(:add_clicks_before)
    prev_click_count = @home_page.button_click_count.text
    @home_page.click_button_click_count
    Browser.wait_for { @home_page.button_click_count.text.to_i == prev_click_count.to_i + 1 }
    @home_page.save_screenshot(:add_clicks_after)

    assert_equal(
      prev_click_count.to_i + 1,
      @home_page.button_click_count.text.to_i,
      "Click count was not incremented"
    )

    Browser.refresh(@home_page.driver)

    assert_equal(
      prev_click_count.to_i + 1,
      @home_page.button_click_count.text.to_i,
      "Click count was not persisted after refresh"
    )
  end
end
