class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :icon]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    #dataフォルダ以下を全部削除
    dataPath = Rails.public_path.join("data")
    FileUtils.rm_rf(dataPath)
    FileUtils.mkdir_p(dataPath) unless FileTest.exist?(dataPath)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #ファイル出力
    @user = User.find(params[:id])
    File.binwrite(Rails.public_path.join(@user.icon_path), Video.find(@user.video_id).video_data)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    params[:user][:icon].each do |file|
      @user = User.new(user_params)
      @user.filename = file.original_filename
      #@user.icon = file.read
      video = Video.create
      video.video_data = file.read
      #10バイトずつ読み込み
      #loop do
      #  r = f.read(10)
      #
      #  if (f.eof)
      #    break
      #  end
      #end
      video.save
      @user.video_id = video.id
      @user.icon_content_type = file.content_type
      @user.save
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def icon_path
    @user = User.find(params[:id])
    render :text => "data/" + @user.filename
    #send_data(Video.find(@user.video_id).video_data, type: @user.icon_content_type, disposition: :inline)
  end
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    video = Video.find(@user.video_id)
    video.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :icon, :icon_content_type)
    end
end
