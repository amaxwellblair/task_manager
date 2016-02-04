require_relative "../test_helper"

class UserEditsTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_user_can_edit_a_task
    set_create
    visit '/'
    click_link('View Tasks')
    assert_equal '/tasks', current_path

    click_link('Edit')
    assert_equal '/tasks/1/edit', current_path

    fill_in('tasks[title]', with: "Chicken")
    fill_in('tasks[description]', with: "or the Egg?")

    click_link_or_button("submit")

    within("#test_task") do
      assert page.has_content?("Chicken")
      assert page.has_content?("or the Egg?")
    end

    #Any user
    #When I visit the task manager home page
    #I click on view tasks
    #I then click on the task I would like to edit
    #I then change the title and description to me liking
    #I then submit the changes
    #Then I should see my changes
  end

end
