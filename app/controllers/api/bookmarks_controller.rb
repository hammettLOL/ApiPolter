class Api::BookmarksController < Api::ApiController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  
  # /bookmarks?user_id=6
  def index
        bookmarks = Bookmark.where(user_id: params[:user_id])
      
      if bookmarks.count == 0
        bookmarks = Bookmark.all
      end
      # bookmarks = Bookmark.includes(:user, :record)
      render json: bookmarks.to_json(only: :id, 
            include: {  user:   { only: [:id, :nickname, :email] }, 
                        record: { only: [:id, :audio_file_name, :audio_content_type] }
            })
  end
 
  def show
    
    # bookmarks = Bookmark[:user_id].eq(params[:user_id]).and(Bookmark[:record_id].matches(params[:user_id]))
    
    bookmarks = Bookmark.find(user_id: params[:user_id])
    # bookmarks = Bookmark.includes(:user, :record)
    render json: bookmarks.to_json(only: :id, 
          include: {  user:   { only: [:id, :nickname, :email] }, 
                      record: { only: [:id, :audio_file_name, :audio_content_type] }
          })
  end
  
  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end
  
  # GET /bookmarks/1/edit
  def edit
  end
  
  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(bookmark_params)
    
    respond_to do |format|
      if @bookmark.save
        # format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        # format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        # format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        # format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy
    respond_to do |format|
      # format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def bookmark_params
    params.require(:bookmark).permit(:user_id, :record_id)
  end
end
