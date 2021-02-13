# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'uri'
require 'net/http'
require 'openssl'
require 'json'


def genre_resolve(name)
  name = "Unknown" unless name
  genre = Genre.find_by(name: name)
  if !genre
    genre = Genre.create(name: name)
  end
  genre
end

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

if Title.all.length > 0
  p "Skipping seeding titles as some exist in the db. Run db:drop or manually delete them before repopulating"
else 
  year = "1982"
  recs = 20
  record_limit = 600
  total = 0
  puts "** Calling IMDB for year #{year}, #{recs} at a time **"
  
  page = 1
  
  loop do
    url = URI("https://movies-tvshows-data-imdb.p.rapidapi.com/?type=get-movies-byyear&page=#{page}&year=#{year}")
    response_hash = get_imdb_data(url)
    count = response_hash["results"]
    total_count = response_hash["Total_results"].to_i
    puts " >> #{(recs * (page - 1))+1} .. #{((recs * (page - 1)) + count)} records of #{total_count} from IMDB received"
    for i in 0..(count-1) do
      title = Title.new
      
      title.title = response_hash["movie_results"][i]["title"]
      imdb_id = response_hash["movie_results"][i]["imdb_id"]
      
      url_by_imdb_id = URI("https://movies-tvshows-data-imdb.p.rapidapi.com/?type=get-movie-details&imdb=#{imdb_id}")
      details_hash = get_imdb_data(url_by_imdb_id)
      
      title.description = details_hash["description"]
      title.release_year = details_hash["year"]
      title.imdb_id = imdb_id
      title.rate_per_day = (details_hash["imdb_rating"].to_f * 10) + 200
      details_hash["genres"].nil? ? genre = "Unknown" : genre = details_hash["genres"][0]
      title.genre = genre_resolve(genre)
      
      title.save
      total += 1
      puts "#{total}. #{title.title} rated #{details_hash["imdb_rating"]}, to rent for #{title.rate_per_day}p/day"
    end
    
    page > total_count/recs ? break : page += 1
    puts "Now page #{page}"
    break if total > record_limit
    puts "DONE: Year #{year} of IMDB **"
  end
end
  
p "Killing all users"
User.all.each do |user|
  user.rentals.delete_all
  user.delete
end

p "Creating Pat Sharp"
user = User.new(
  firstname: "Pat",
  lastname: "Sharp",
  email: "patsharp@retro.com",
  password: "password"
)
user.save

p "Creating a bunch of rentals for Pat Sharp"
10.times do
  title = Title.all.sample
  start_date = Date.new(1982, (1..12).to_a.sample, (1..28).to_a.sample)
  p "Pat Sharp rents out #{title.title}"
  rental = Rental.create(
    title: title,
    user: user,
    start_date: start_date
  )
  rental.end_date = start_date + 14 if rand() > 0.5
end