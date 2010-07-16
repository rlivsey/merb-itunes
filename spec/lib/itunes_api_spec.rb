require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ItunesAPI do
  describe "#find_album" do
    describe "when the API returns no results" do
      it "should return nil" do

      end
    end

    describe "when the API returns results, but no albums" do
      it "should return nil" do

      end
    end

    describe "when the API returns multiple albums" do
      it "should return the first album in the list" do

      end
    end

    describe "when the API returns one album" do
      it "should return the album" do

      end
    end

    describe "when the API returns an artist with albums" do
      it "should return the first album in the list" do

      end
    end
  end
end