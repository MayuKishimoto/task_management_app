class TasksController < ApplicationController
  def index
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && status.present?
        @tasks = current_user.tasks.title_search(title).status_search(status).page(params[:page])
      elsif title.present? && status.blank?
        @tasks = current_user.tasks.title_search(title).page(params[:page])
      else
        @tasks = current_user.tasks.status_search(status).page(params[:page])
      end
    elsif params[:sort_expired]
      @tasks = current_user.tasks.order(expired_at: :desc).page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page])
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to task_path(@task.id), notice: "タスクを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority, label_ids: [])
  end
end
