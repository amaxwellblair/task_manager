ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/erb'
require 'capybara'
require 'capybara/dsl'

Capybara.app = TaskManagerApp

Capybara.save_and_open_page_path = 'tmp/capybara'

module TestHelpers

  def teardown
    task_manager.delete_all
    super
  end

  def task_manager
    database = YAML::Store.new("db/task_manager_test")
    @task_manager_test ||= TaskManager.new(database)
  end

  def set_create
    data = {
      title:       'some title',
      description: 'some description'
    }
    task_manager.create(data)
  end

end
