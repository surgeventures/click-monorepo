# frozen_string_literal: true

class HomePage
  module Elements
    def button_click_count
      driver.find_element(:id, "click-count")
    end

    def p_lead
      driver.find_element(:class, "lead")
    end
  end
end
