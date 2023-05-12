class LabelsController < ApplicationController
  before_action :require_admin

  def index
    @labels = Label.select(:name)
  end

  def show
    @label = Label.find(params[:id])
  end

  def new
    @label = Label.new
  end

  def edit
    @label = Label.find(params[:id])
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path(@label), notice: "ラベル「#{@label.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      redirect_to labels_path(@label), notice: "ラベル「#{@label.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path, notice: "ラベル「#{@label.name}」を削除しました。"
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def require_admin
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.admin?
  end
end
