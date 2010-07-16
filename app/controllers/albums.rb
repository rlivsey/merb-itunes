class Albums < Application
  
  before :get_album, :only => [:show, :update]
  
  def index
    @albums = Album.all
    render
  end

  def show
    render
  end

  def new
    @album = Album.new
    render
  end

  def create
    unless @album = Album.first(:itunes_id => params[:album][:itunes_id])
      if json = ItunesAPI.find_album(params[:album][:itunes_id])
        @album = Album.from_json(json)
      end
    end
    
    if @album && @album.save
      return redirect(url(:album, @album.id))
    end
    
    render :new
  end

  def update
    if json = ItunesAPI.find_album(@album.itunes_id)
      @album.populate_with_json(json)
      if @album.save
        return redirect(url(:album, @album.id))
      end
    end
    
    render
  end

  private
  
  def get_album
    unless @album = Album.get(params[:id])
      raise NotFound
    end
  end

end