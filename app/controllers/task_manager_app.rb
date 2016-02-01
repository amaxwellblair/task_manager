require 'sinatra/base'
require 'yaml/store'
require 'models/task_manager'

class TaskManagerApp < Sinatra::Base

  set :root, File.expand_path("..", __dir__)

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = task_manager.all
    erb :template, :layout => false do
      erb :index
    end
  end

  post '/tasks/new' do
    task_manager.create(params[:tasks])
    redirect :tasks
  end

  get '/tasks/new' do
    erb :template, :layout => false do
      erb :new
    end
  end

  get '/tasks/:id' do |id|
    @task = task_manager.find(id.to_i)
    erb :show
  end

end

def task_manager
  database = YAML::Store.new("db/task_manager")
  @task_manager ||= TaskManager.new(database)
end
