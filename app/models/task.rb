class Task
  attr_reader :id, :title, :description

  def initialize(task)
    @id = task['id']
    @title = task['title']
    @description = task['description']
  end

end
