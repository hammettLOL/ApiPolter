class Api::UsersController < Api::ApiController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
      # users = User.all
      users = User.includes(:records)
      render json: users.to_json(only: [:id, :user_id, :email, :nickname], 
      include: {records: {only: [:record_id, :geolocation, :audio_file_name, :audio_content_type]}})
  end
    
  def show
      user = User.find(params[:id])
      render json: user.to_json(except: [:id, :user_id, :email, :nickname])
  end
end
