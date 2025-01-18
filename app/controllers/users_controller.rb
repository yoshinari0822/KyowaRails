class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def edit
  end

  # 生成AIが作成。ユーザー情報を変更する
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "ユーザー情報が更新されました。"
    else
      render :edit
    end
  end

  def show
    # ------生成AIが作成------
    @user_diaries = @user.diaries
    # ------生成AIが作成------
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :icon)
  end
end
