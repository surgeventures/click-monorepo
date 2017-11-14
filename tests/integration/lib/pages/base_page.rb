# frozen_string_literal: true

class BasePage
  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end
end
