require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_can_create_a_task
    data = {
      title:       'some title',
      description: 'some description'
    }
    task_manager.create(data)

    task = task_manager.all.last

    assert task.id
    assert_equal "some title", task.title
    assert_equal "some description", task.description
  end

  def test_can_output_all_tasks
    3.times do |index|
      data = {
        title:       'some title',
        description: 'some description'
      }
      task_manager.create(data)
    end
    tasks = task_manager.all

    assert_equal 3, tasks.length
  end

  def test_can_find_specific_tasks
    3.times do |index|
      data = {
        title:       'some title',
        description: 'some description'
      }
      task_manager.create(data)
    end
    task = task_manager.find(3)

    assert_equal 3, task.id
  end

  def test_can_update_a_specific_task
    3.times do |index|
      data = {
        title:       'some title',
        description: 'some description'
      }
      task_manager.create(data)
    end
    updateData = {
      title:       'new title',
      description: 'new description'
    }
    task = task_manager.update(3, updateData)

    assert_equal 'new title', task_manager.all.last.title
    assert_equal 'new description', task_manager.all.last.description
  end

  def test_can_destroy_a_specfic_task
    3.times do |index|
      data = {
        title:       'some title',
        description: 'some description'
      }
      task_manager.create(data)
    end

    task_manager.delete(3)

    refute_equaln 3, task_manager.all.last.id
  end

end
