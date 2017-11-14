# frozen_string_literal: true

class Browser
  class << self
    def wait_for(seconds)
      Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
    end

    def hover(element, driver)
      driver.action.move_to(element).perform
    end

    def refresh(driver)
      driver.navigate.refresh
    end
  end
end
