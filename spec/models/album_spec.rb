require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Album do  
  describe ".from_json" do
    before(:each) do
      @json = JSON.parse(fixture_file("album.json").read)["results"][0]
    end
    
    it "should instantiate a new album and call #populate_from_json on it" do
      album = mock(:album)
      Album.stub!(:new).and_return(album)
      album.should_receive(:populate_from_json).with(@json)
      Album.from_json(@json)
    end
    
    it "should return an album" do
      Album.from_json(@json).should be_a(Album)
    end
  end
  
  describe "#populate_from_json" do
    before(:each) do
      @json = JSON.parse(fixture_file("album.json").read)["results"][0]
      @album = Album.new
    end
    
    it "should initialize a new album populated with the JSON data passed" do
      @album.populate_from_json(@json)
      
      {
        :collection_explicitness   => "notExplicit",
        :collection_name           => "X & Y",
        :country                   => "USA",
        :artwork_url100            => "http://a1.phobos.apple.com/us/r1000/000/Features/7b/09/42/dj.damrffnz.100x100-75.jpg",
        :artist_id                 => 471744,
        :wrapper_type              => "collection",
        :primary_genre_name        => "Alternative",
        :artwork_url60             => "http://a1.phobos.apple.com/us/r1000/000/Features/7b/09/42/dj.damrffnz.60x60-50.jpg",
        :collection_view_url       => "http://itunes.apple.com/us/album/x-y/id66314629?uo=4",
        :collection_price          => 7.99,
        :amg_video_artist_id       => nil,
        :collection_type           => "Album",
        :release_date              => DateTime.new(2006, 8, 14, 7, 0),
        :track_count               => 13,
        :copyright                 => "2005 The copyright in this sound recording is owned by EMI Records Ltd",
        :artist_view_url           => "http://itunes.apple.com/us/artist/coldplay/id471744?uo=4",
        :collection_censored_name  => "X & Y",
        :artist_name               => "Coldplay",
        :amg_artist_id             => 435023,
        :collection_id             => 66314629,
        :currency                  => "USD"
       }.each do |key, value|
         @album.send(key).should == value
       end
    end
    
    it "should not die if the JSON contains an attribute it doesn't know about" do
      @json["somethingUnknown"] = "something"
      lambda {
        @album.populate_from_json(@json)
      }.should_not raise_error
    end
  end
end