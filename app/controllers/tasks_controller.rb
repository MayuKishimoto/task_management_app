class TasksController < ApplicationController
  def index
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.where('title LIKE ? AND status LIKE ?', "%#{params[:task][:title]}%", "#{params[:task][:status]}")
      elsif params[:task][:title].present? && params[:task][:status].blank?
        @tasks = Task.where('title LIKE ?', "%#{params[:task][:title]}%")
      else
        @tasks = Task.where(status: params[:task][:status])
      end
    elsif params[:sort_expired]
      @tasks = Task.order(expired_at: :desc)
    else
      @tasks = Task.order(created_at: :desc)
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
    params.require(:task).permit(:title, :content, :expired_at, :status)
  end
end
