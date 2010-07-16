require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

ITUNES_API_URI = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsLookup"

describe ItunesAPI do
  describe "#find_album" do
    it "should call the iTunes API with the correct ID" do
      stub_request(:get, "#{ITUNES_API_URI}?id=123456")
      ItunesAPI.find_album(123456)
      WebMock.should have_requested(:get, "#{ITUNES_API_URI}?id=123456")
    end

    it "should return nil when the API returns no results" do
      stub_request(:get, "#{ITUNES_API_URI}?id=123456").to_return(:body => fixture_file("nothing.json"))
      ItunesAPI.find_album(123456).should be_nil
    end

    it "should return nil when the API returns results, but no albums" do
      stub_request(:get, "#{ITUNES_API_URI}?id=123456").to_return(:body => fixture_file("no_albums.json"))
      ItunesAPI.find_album(123456).should be_nil
    end

    it "should return the first album in the list when the API returns multiple albums" do
      stub_request(:get, "#{ITUNES_API_URI}?id=123456").to_return(:body => fixture_file("albums.json"))
      album = ItunesAPI.find_album(123456)
      album.should_not be_nil
      album["collectionId"].should == 66314629
    end

    it "should return the album when the API returns one album" do
      stub_request(:get, "#{ITUNES_API_URI}?id=123456").to_return(:body => fixture_file("album.json"))
      album = ItunesAPI.find_album(123456)
      album.should_not be_nil
      album["collectionId"].should == 66314629
    end

    it "should return the first album in the list when the API returns an artist with albums" do
      stub_request(:get, "#{ITUNES_API_URI}?id=123456").to_return(:body => fixture_file("artist_and_albums.json"))
      album = ItunesAPI.find_album(123456)
      album.should_not be_nil
      album["collectionId"].should == 373809929
    end
  end
end