require 'yaml/store'

class TaskManagerApp < Sinatra::Base

  set :root, File.expand_path("..", __dir__)
  set :method_override, :true


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
    erb :template, :layout => false do
      erb :show
    end
  end

  get '/tasks/:id/edit' do |id|
    @task = task_manager.find(id.to_i)
    erb :template, :layout => false do
      erb :edit
    end
  end

  put '/tasks/:id/edit' do |id|
    task_manager.update(id.to_i, params[:tasks])
    redirect "/tasks/#{id}"
  end

  delete '/tasks/:id' do |id|
    task_manager.delete(id.to_i)
    redirect "/tasks"
  end

  not_found do
    erb :template, :layout => false do
      erb :error
    end
  end

end

def task_manager
  if ENV['RACK_ENV'] == 'test'
    database = YAML::Store.new("db/task_manager_test")
  else
    database = YAML::Store.new("db/task_manager")
  end
  @task_manager ||= TaskManager.new(database)
end
