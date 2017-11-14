# frozen_string_literal: true

class Browser
  class << self
    def wait_for(seconds = 5)
      Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
    end

    def refresh(driver)
      driver.navigate.refresh
    end
  end
end
