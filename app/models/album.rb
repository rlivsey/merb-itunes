class Album
  include DataMapper::Resource
  include DataMapper::Timestamps

  property :id,                       Serial
  property :itunes_id,                Integer, :required => true
  property :collection_explicitness,  String
  property :collection_name,          String
  property :country,                  String
  property :artwork_url100,           String
  property :artist_id,                Integer
  property :wrapper_type,             String
  property :primary_genre_name,       String
  property :artwork_url60,            String
  property :collection_view_url,      String
  property :collection_price,         Float     # note, should really store money as Integer
  property :amg_video_artist_id,      Integer
  property :collection_type,          Integer
  property :release_date,             DateTime
  property :track_count,              Integer
  property :copyright,                String
  property :artist_view_url,          String
  property :collection_censored_name, String
  property :artist_name,              String
  property :amg_artist_id,            Integer
  property :collection_id,            Integer
  property :currency,                 String

  timestamps :at

  # convert keys to snake_case and assign if the property exists
  def self.from_json(json)
    album = new
    json.each do |key, value|
      key = key.to_s.snake_case
      album.send(:"#{key}=", value) if album.respond_to?(:"#{key}=")
    end
    album
  end
end