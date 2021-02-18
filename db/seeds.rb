# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


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

def create_rentals(user)
  p "Creating a bunch of rentals for #{user.firstname}"
  10.times do
    title = Title.all.sample
    start_date = Date.new(1982, (1..12).to_a.sample, (1..28).to_a.sample)
    p "#{user.firstname} rents out #{title.title}"
    rental = Rental.new(
      title: title,
      user: user,
      start_date: start_date.to_datetime
    )
    rental.end_date = (start_date + 14).to_datetime if rand() > 0.5
    rental.save
  end
end

def create_users
  user_array = [
    {firstname: "Pat", lastname: "Sharp", address1: "89 High Street", address2: "Teddington", postcode: "TW11 8HG"},
    {firstname: "Bob", lastname: "Hope", address1: "18 Teddington Park Rd", address2: "Teddington", postcode: "TW11 0AQ"},
    {firstname: "Kylie", lastname: "Manogue", address1: "70 London Rd", address2: "Kingston upon Thames", postcode: "KT2 6PY"},
    {firstname: "Cyril", lastname: "Shepard", address1: "210 Kingston Rd", address2: "Teddington", postcode: "TW11 9JF"},
    {firstname: "Bruce", lastname: "Willis", address1: "113 Heath Rd", address2: "Twickenham", postcode: "TW1 4AZ"},
    {firstname: "Knight", lastname: "Rider", address1: "427 Richmond Rd", address2: "Twickenham", postcode: "TW1 2EF"},
    {firstname: "Metal", lastname: "Mickey", address1: "11 Upper Teddington Rd", address2: "Hampton Wick", postcode: "KT1 4DL"},
    {firstname: "Roland", lastname: "Rat", address1: "19 Upper Ham Rd", address2: "Ham", postcode: "KT2 5QX"}
    ]

  user_array.each do |user|
    p "Creating #{user[:firstname]} #{user[:lastname]}"
    user = User.new(
      firstname: user[:firstname],
      lastname: user[:lastname],
      email: "#{user[:firstname]}#{user[:lastname]}@retro.com",
      password: "password",
      address1: user[:address1],
      address2: user[:address2],
      postcode: user[:postcode]
    )
    user.save
    create_rentals(user)
  end
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


if Title.all.length > 0 then
  p "Skipping seeding titles as some exist in the db. Run db:drop or manually delete them before repopulating"
else
  year = "1982"
  recs = 20
  record_limit = 100
  total = 0
  puts "** Calling IMDB for year #{year}, #{recs} at a time **"

  page = 1

  loop do
    url = URI("https://movies-tvshows-data-imdb.p.rapidapi.com/?type=get-movies-byyear&page=#{page}&year=#{year}")
    response_hash = get_imdb_data(url)
    count = response_hash["results"].to_i || 0
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
      rating = details_hash["imdb_rating"] || 0
      title.rate_per_day = (rating.to_f * 10) + 200
      details_hash["genres"].nil? ? genre = "Unknown" : genre = details_hash["genres"][0]
      title.genre = genre_resolve(genre)

      title.save
      total += 1
      puts "#{total}. #{title.title} rated #{rating}, to rent for #{title.rate_per_day}p/day"
    end

    page += 1

    if total > record_limit
      break
    end
  end
end

p "Killing all users"
User.all.each do |user|
  user.rentals.delete_all
  user.delete
end

create_users
