class TasksController < ApplicationController
  def index
    # @task_pages = Task.page(params[:page]).per(10)
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && status.present?
        @tasks = Task.title_search(title).status_search(status).page(params[:page])
      elsif title.present? && status.blank?
        @tasks = Task.title_search(title).page(params[:page])
      else
        @tasks = Task.status_search(status).page(params[:page])
      end
    elsif params[:sort_expired]
      @tasks = Task.order(expired_at: :desc).page(params[:page])
    elsif params[:sort_priority]
      @tasks = Task.order(priority: :desc).page(params[:page])
    else
      @tasks = Task.order(created_at: :desc).page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end
