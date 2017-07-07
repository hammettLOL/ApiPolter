class Api::RecordsController < Api::ApiController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  
  def index
    records = Record.all
    #records = Record.include(:users)
    render json: records.to_json(only: [:id, :geolocation, :audio_file_name, :audio_content_type], 
    include: {user: {only: [:id, :nickname, :email]}})
  end
    
  def show
    record = Record.find(params[:id])
    #render json: record.to_json(only: [:id, :name, :description, :startTime, :musicalgenre], methods: [:photoUrls])
    render json: record.to_json(only: [:id, :geolocation, :audio_file_name, :audio_content_type], 
    include: {user: {only: [:id, :nickname, :email]}})
  end
  
  def new
    @record = Record.new
  end
  
  # GET /records/1/edit
  def edit
  end
  
  def create
    @record = Record.new(record_params)
    respond_to do |format|
      if @record.save
        # format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @record }
      else
        # format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @record.destroy
    respond_to do |format|
      # format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def update
    respond_to do |format|
      if @record.update(record_params)
        # format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        # format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:user_id, :visits, :audio_file_name, :enabled, :audio)
    end
end
