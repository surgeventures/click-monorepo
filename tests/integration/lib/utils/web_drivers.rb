# frozen_string_literal: true

require "selenium-webdriver"

module WebDrivers
  def self.default
    driver = ENV.fetch("WEBDRIVER", "chrome")

    unless respond_to?(driver)
      raise ArgumentError, "Unknown web driver selected: #{driver}"
    end

    send(driver)
  end

  def self.chrome
    Selenium::WebDriver.for :chrome
  end

  def self.chrome_headless
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")
    Selenium::WebDriver.for :chrome, options: options
  end

  def self.chrome_docker
    Selenium::WebDriver.for(
      :remote,
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome,
      url: "#{ENV.fetch('SELENIUM_URL')}/wd/hub"
    )
  end

  def self.firefox_docker
    Selenium::WebDriver.for(
      :remote,
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox,
      url: "#{ENV.fetch('SELENIUM_URL')}/wd/hub"
    )
  end

  def self.firefox
    Selenium::WebDriver.for :firefox
  end

  def self.firefox_headless
    headless = Headless.new(display: 100)
    headless.start
    Selenium::WebDriver.for :firefox
  end

  def self.safari
    Selenium::WebDriver.for :safari
  end
end
