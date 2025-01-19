class DiariesController < ApplicationController
  before_action :set_diary, only: %i[ show edit update destroy ]

  # GET /diaries or /diaries.json
  # ------生成AIが作成------
  def index
    if params[:user_id].present?
      user_id = params[:user_id]
      @user_diaries = Diary.where(user_id: user_id).order(created_at: :asc)
    else
      @user_diaries = Diary.none
    end
    @diaries_by_date = Diary.includes(:user).order(created_at: :desc).group_by { |diary| diary.created_at.to_date }
  end

  # ------生成AIが作成------

  # GET /diaries/1 or /diaries/1.json
  def show
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
  end

  # POST /diaries or /diaries.json
  def create
    @diary = Diary.new(diary_params)
    # 生成AIが作成。日記のユーザーIDを現在ログインしているユーザーのIdにする
    @diary.user_id = current_user.id

    respond_to do |format|
      if @diary.save
        format.html { redirect_to @diary, notice: "Diary was successfully created." }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diaries/1 or /diaries/1.json
  def update
    respond_to do |format|
      if @diary.update(diary_params)
        format.html { redirect_to current_user, notice: "Diary was successfully updated." }
        format.json { render :show, status: :ok, location: @diary }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1 or /diaries/1.json
  def destroy
    @diary.destroy!

    respond_to do |format|
      format.html { redirect_to diaries_path, status: :see_other, notice: "Diary was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diary_params
      params.require(:diary).permit(:user_id, :text, :tension)
    end
end
