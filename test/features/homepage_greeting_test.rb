require_relative '../test_helper'

class HomePageGreetingTest < Minitest::Test
  include Capybara::DSL

  def test_home_page_welcomes_user

    visit '/'
    within("#greeting") do
      assert page.has_content?("Welcome to the TaskManager")
    end


    # As a user
    # when I viist the home page
    # Then I see a "Welcome to the TaskManager!"
  end

end
