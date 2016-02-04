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

  def all()
    raw_tasks.map{|task| Task.new(task)}
  end

  def raw_task(id)
    raw_tasks.find{|task| task['id'] == id }
  end

  def find(id)
    Task.new(raw_task(id))
  end

  def update(id, data)
    database.transaction do
      raw_tasks = database['tasks'] || []
      raw_task = raw_tasks.find{ |task| task['id'] == id }
      raw_task['title'] = data[:title]
      raw_task['description'] = data[:description]
    end
  end

  def delete(id)
    database.transaction do
      database['tasks'].delete_if{ |task| task['id'] == id}
    end
  end

  def delete_all()
    database.transaction do
      database['tasks'] = []
      database['total'] = 0
    end
  end

end
