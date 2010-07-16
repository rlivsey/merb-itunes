# Helper to search the iTunes API
#
# For now this just returns the parsed JSON as a hash, it's conceivable that
# this could transform them into nicer objects if needed
#
# For this exercise we're just concerned with looking up individual albums,
# so that's all that's implemented
#
# See the docs for details on the full API
# http://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html

require 'net/http'
require 'uri'

module ItunesAPI

  API_URI = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsLookup"

  def self.find_album(id)
    uri      = URI.parse("#{API_URI}?id=#{id}")
    response = Net::HTTP.get_response(uri)

    begin
      results = JSON.parse(response.body)
    rescue JSON::ParserError
     # silently fail for now, in future we will want to handle this appropriately
     return
    end

    return if results["resultCount"] == 0

    # return the first album we find
    results["results"].find{|result| result["collectionType"] == "Album" }
  end
end