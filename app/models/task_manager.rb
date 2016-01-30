require 'models/task'

class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    database.transaction do
      database['total'] ||= 0
      database['total'] += 1
      database['tasks'] ||= []
      database['tasks'].push(
        {
          'id' => database['total'],
          'title' => task[:title],
          'description' => task[:description]
        }
      )
    end
  end

  def raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def all
    raw_tasks.map{|task| Task.new(task)}
  end

  def raw_task(id)
    raw_tasks.find{|task| task['id'] == id }
  end

  def find(id)
    puts raw_task(id)
    Task.new(raw_task(id))
  end

end
