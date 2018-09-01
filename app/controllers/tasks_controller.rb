class TasksController < ApplicationController
  before_action :auth_user

  def index
    @tasks = curent_user.tasks
  end
end
