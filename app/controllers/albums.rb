require 'pp'

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
    unless @album = Album.first(:collection_id => params[:album][:collection_id])
      @album = Album.new
    end

    if json = ItunesAPI.find_album(params[:album][:collection_id])
      @album.populate_from_json(json)
    end

    if @album.save
      return redirect(url(:album, @album.id))
    end

    message[:error] = "No price found for the album"
    render :new
  end

  def update
    if json = ItunesAPI.find_album(@album.collection_id)
      @album.populate_from_json(json)
      if @album.save
        return redirect(url(:album, @album.id), :message => {:notice => "The price was updated"})
      end
    end

    message[:error] = "No price found for the album"
    render
  end

  private

  def get_album
    unless @album = Album.get(params[:id])
      raise NotFound
    end
  end

end