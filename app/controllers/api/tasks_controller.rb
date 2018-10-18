class Api::TasksController < Api::ApiController
    before_action :auth_user

    def index
      @tasks = curent_user.tasks
      @tasks=@tasks.order(title: params[:order]) if params[:order].present?
      render json: { tasks: @tasks }, status: 200
    end
  
    def show
      @task = curent_user.tasks.find(params[:id])
      render json: { task: @task }, status: 200
    end
  
    def create
      @task = curent_user.tasks.create(task_params)
      if @task.errors.any?
        render json: { error: @task.errors.full_messages.to_sentence }, status: 402
      else
        render json: {}, status: 200
      end
    end

    def update
      @task = curent_user.tasks.find(params[:id])
      @task.update(task_params)
      if @task.errors.any?
        render json: { errors: @task.errors.full_messages.to_sentence }, status: 402
      else
        render json: {}, status: 200
      end
    end
  
    def destroy
      if params[:batch].present?
        params[:batch].each do |id|
          task = curent_user.tasks.find(id)
          task.destroy if task
        end
      else
        curent_user.tasks.find(params[:id]).destroy
      end
      render json: { message: 'success' }, status: 200
    end
  
    private
  
    def task_params
      params.require(:task).permit(:title, :description, :duedate, :priority, :done)
    end
end