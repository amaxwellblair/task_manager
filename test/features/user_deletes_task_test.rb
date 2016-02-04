require_relative '../test_helper'

class UserDeletesTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_user_can_delete_a_task
    set_create
    visit '/'
    click_link("View Tasks")
    click_link_or_button("DELETE")

    within('#tasks') do
      refute page.has_content?("some title")
      refute page.has_content?("some description")
    end


    #An unathenticated user
    #When visiting the home page
    #user clicks the view tasks link
    #user clicks the delete tasks link
    #then the user expects to see the task missing from the tasks page
  end

end
