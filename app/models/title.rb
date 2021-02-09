class Title < ApplicationRecord
  belongs_to :genre
  has_many :rentals
  has_many :users, through: :rental
  validates :title, presence: true

  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  def imdb_details
    url = URI("https://movies-tvshows-data-imdb.p.rapidapi.com/?type=get-movie-details&imdb=#{imdb_id}")
    get_imdb_data(url)
  end

  def imdb_poster
    url = URI("https://movies-tvshows-data-imdb.p.rapidapi.com/?type=get-movies-images-by-imdb&imdb=#{imdb_id}")
    get_imdb_data(url)
  end

  private

  def get_imdb_data(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = ENV.fetch('RAPID_IMDB_API_KEY')
    request["x-rapidapi-host"] = 'movies-tvshows-data-imdb.p.rapidapi.com'

    response = http.request(request)
    JSON.parse(response.body)
  end
end
