# frozen_string_literal: true

class BasePage
  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def save_screenshot(name)
    full_name = "#{self.class}_#{name.to_s.split('_').collect(&:capitalize).join}"

    FileUtils.mkdir_p("screenshots")
    driver.save_screenshot("screenshots/#{full_name}.png")
  end
end
