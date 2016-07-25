class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def edit
    @user = User.find(params[:user_id])
    @upload = Upload.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @upload = @user.uploads.create(upload_params)
    if @upload.save
      @upload["public_id"] = Cloudinary::Uploader.upload(@upload.image.path)["public_id"]
      @user.uploads.push(@upload)
      render json: { message: "success" }, :status => 200
    else
      render json: { error: @upload.errors.full_messages.join(',')}, :status => 400
    end
  end

  def update
    @user = User.find(params["user_id"])
    @upload = @user.uploads.find_by public_id: params["public_id"]
    if !@upload
      render json: { error: @upload.errors.full_messages.join(',')}, :status => 404
      return
    end
    @upload["public_id"] = Cloudinary::Uploader.upload(params["new_url"], :format => 'png')["public_id"]
    if @upload.save
      @user.uploads.push(@upload)
      render json: { message: "success" }, :status => 200
    else
      render json: { error: @upload.errors.full_messages.join(',')}, :status => 400
    end
  end

  private
  def upload_params
    params.require(:upload).permit(:image)
  end
end
