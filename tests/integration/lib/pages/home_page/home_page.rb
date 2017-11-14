# frozen_string_literal: true

class HomePage < BasePage
  include Elements
  include Actions

  PATH = "#{ENV['CLICK_CLIENT_URL']}/"

  def open_via_url
    driver.navigate.to PATH
    self
  end
end
