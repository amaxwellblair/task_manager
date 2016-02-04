require_relative '../test_helper'

class UserCreatesTaskTest < Minitest::Test
  include Capybara::DSL

  def test_with_valid_attributes
    visit '/'
    click_link("New Task")
    fill_in("tasks[title]", with: "Test")
    fill_in("tasks[description]", with: "Description")
    click_link_or_button("submit")

    assert_equal '/tasks', current_path
    within("#tasks") do
      assert page.has_content?("Test")
    end

    #As a user
    #When I visit the home page
    #I click on create new task
    #and I fill in the test_with_valid_attributes
    #and I fill in the description
    # and I click submit
    # Then I should see my task
  end

end
