class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

   def save_image
   	p params
    unless params[:image].empty?
      data = params[:image]
      image_data = Base64.decode(data['data:image/png;base64,'.length..-1])
      p image_data
      redirect_to user_path(current_user)
    end
  end
end
