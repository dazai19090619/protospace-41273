class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all.includes(:user)
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to @prototype, notice: 'プロトタイプを投稿しました。'
    else
      render :new
    end
  end

  def edit
    # @prototypeはbefore_actionでセット済み
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'プロトタイプを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: 'プロトタイプを削除しました。'
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def ensure_correct_user
    unless current_user == @prototype.user
      redirect_to root_path, alert: "権限がありません。"
    end
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end
end
