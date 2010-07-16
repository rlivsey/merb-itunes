require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Albums do

  describe "GET index" do
    def do_request
      dispatch_to(Albums, :index) do |controller|
        controller.stub!(:render)
      end
    end

    it "should assign the albums already found" do
      albums = [mock(:album), mock(:album)]
      Album.should_receive(:all).and_return(albums)
      do_request.assigns(:albums)
    end
  end

  describe "GET show" do
    def do_request
      dispatch_to(Albums, :show, :id => 1) do |controller|
        controller.stub!(:render)
      end
    end

    describe "with existing album" do
      before(:each) do
        @album = mock(:album)
        Album.stub!(:get).and_return(@album)
      end

      it "should be succesful" do
        do_request.should be_successful
      end

      it "should assign the album" do
        Album.should_receive(:get).with('1').and_return(@album)
        do_request.assigns(:album).should == @album
      end
    end

    describe "with album that doesn't exist" do
      it "should raise an error" do
        lambda {
          do_request
        }.should raise_error
      end
    end
  end

  describe "GET new" do
    def do_request
      dispatch_to(Albums, :new) do |controller|
        controller.stub!(:render)
      end
    end

    before(:each) do
      @album = mock(:album)
      Album.stub!(:get).and_return(@album)
    end

    it "should assign an album for the view" do
      Album.should_receive(:new).and_return(@album)
      do_request.assigns(:album).should == @album
    end

    it "should be successful" do
      do_request.should be_successful
    end
  end

  describe "POST create" do
    before(:each) do
      stub_request(:get, "#{ItunesAPI::API_URI}?id=1")
    end

    def do_request
      dispatch_to(Albums, :create, :album => {:itunes_id => 1}) do |controller|
        controller.stub!(:render)
      end
    end

    it "should call the iTunes API" do
      do_request
      WebMock.should have_requested(:get, "#{ItunesAPI::API_URI}?id=1")
    end

    describe "with new album ID" do
      before(:each) do
        stub_request(:get, "#{ItunesAPI::API_URI}?id=1").to_return(:body => fixture_file("album.json"))
      end

      it "should create a new album from the iTunes JSON" do
        album = mock(:album)
        Album.should_receive(:from_json).and_return(album)
        album.should_receive(:save).and_return(true)

        do_request
      end

      it "should redirect to the album page" do
        album = mock(:album)
        Album.stub!(:from_json).and_return(album)
        album.stub!(:save).and_return(true)
        album.stub!(:id).and_return(123)

        do_request.should redirect_to(url(:album, 123))
      end
    end

    describe "with invalid album ID" do
      before(:each) do
        stub_request(:get, "#{ItunesAPI::API_URI}?id=1").to_return(:body => fixture_file("nothing.json"))
      end

      it "should stay on the form to display an error" do
        do_request.should_not redirect_to(url(:album, 1))
      end
    end

    describe "with existing album ID" do
      before(:each) do
        stub_request(:get, "#{ItunesAPI::API_URI}?id=1").to_return(:body => fixture_file("album.json"))
      end

      it "should update the album" do
        album = mock(:album)
        Album.should_receive(:first).and_return(album)
        album.should_receive(:save).and_return(true)

        do_request
      end

      it "should redirect to the album page" do
        album = mock(:album)
        Album.stub!(:first).and_return(album)
        album.stub!(:save).and_return(true)
        album.stub!(:id).and_return(456)

        do_request.should redirect_to(url(:album, 456))
      end
    end
  end

  describe "PUT update" do
    def do_request
      dispatch_to(Albums, :update, :album => {:itunes_id => 1}) do |controller|
        controller.stub!(:render)
      end
    end

    describe "with a valid iTunes ID" do
      before(:each) do
        stub_request(:get, "#{ItunesAPI::API_URI}?id=1").to_return(:body => fixture_file("album.json"))

        @album = mock(:album)
        @album.stub!(:itunes_id).and_return(1)
        @album.stub!(:id).and_return(123)
        @album.stub!(:populate_with_json)
        @album.stub!(:save).and_return(true)
        Album.stub!(:get).and_return(@album)
      end

      it "should call the iTunes API" do
        do_request
        WebMock.should have_requested(:get, "#{ItunesAPI::API_URI}?id=1")
      end

      it "should update the album from the iTunes JSON" do
        @album.should_receive(:populate_with_json)
        @album.should_receive(:save).and_return(true)
        do_request
      end

      it "should redirect to the album page" do
        do_request.should redirect_to(url(:album, 123))
      end
    end

    describe "with a no longer valid iTunes ID" do
      before(:each) do
        stub_request(:get, "#{ItunesAPI::API_URI}?id=1").to_return(:body => fixture_file("nothing.json"))

        @album = mock(:album)
        @album.stub!(:itunes_id).and_return(1)
        @album.stub!(:id).and_return(123)
        Album.stub!(:get).and_return(@album)
      end

      it "should call the iTunes API" do
        do_request
        WebMock.should have_requested(:get, "#{ItunesAPI::API_URI}?id=1")
      end

      it "should not update the album from the iTunes JSON" do
        @album.should_not_receive(:populate_with_json)
        @album.should_not_receive(:save)
        do_request
      end

      it "should not redirect to the album page" do
        do_request.should_not redirect_to(url(:album, 123))
      end
    end

  end
end