# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'httparty'
require 'open-uri'


puts "Clearing database..."
ReservationReview.destroy_all
Booking.destroy_all
Listing.destroy_all
User.destroy_all
Book.destroy_all


puts "Creating users..."
users = [
  { email: "buyer1@example.com", password: "password", name: "Mia Lauper", address: "2836234 Rainbow Road"  },
  { email: "buyer2@example.com", password: "password", name: "Liam Jackson", address: "Somewhere up north"  },
  { email: "seller1@example.com", password: "password", name: "The Artist Formerly Known As Julian", address: "1 Tokyo Road"  },
  { email: "seller2@example.com", password: "password", name: "Ben Rotten", address: "6 Hell" }
]
users.each { |user| User.create!(user) }

puts "Fetching books from Open Library API..."
response = HTTParty.get("https://openlibrary.org/search.json?q=fiction&limit=25")
books_data = response.parsed_response["docs"]


puts "Creating books..."
sellers = User.all
books_data.each do |book_data|
  book = Book.new(
    title: book_data["title"],
    author: book_data["author_name"]&.join(", ") || "Unknown Author",
    publication_date: DateTime.new(book_data["first_publish_year"]) || "Date Unknown",
    cover_url: "https://covers.openlibrary.org/b/id/#{book_data["cover_i"]}-L.jpg"
  )
  book.save
end


puts "Creating listings..."
buyers = User.all
books = Book.all
books.sample(20).each do |book|
  listing = Listing.new(
    book: book,
    user: buyers.sample,
    title: "#{book.title} #{['used', 'great condition', 'signed by author', 'bit skanky'].sample}",
    price: rand(50..350),
    condition: "Used",
    comment: "Delicious book, slightly used. Comes complete with original dust jacket and coffee stains."
  )

  cover_id = books_data.find { |b| b["title"] == book.title }&.dig("cover_i")
  if cover_id
    image_url = "https://covers.openlibrary.org/b/id/#{cover_id}-L.jpg"
    downloaded_image = URI.open(image_url)
    listing.image.attach(
      io: downloaded_image,
      filename: "#{book.title.parameterize}.jpg",
      content_type: "image/jpeg"
    )
  end
  listing.save
end


puts "Creating reviews..."
bookings = Booking.all


puts "Creating reviews..."
reviews_comments = [
  "This book is amazing!",
  "A fantastic read, highly recommend!",
  "I couldn't put this book down!",
  "Great book! Must read for everyone!",
  "Interesting story, well-written!",
  "Super fun book, really engaging!",
  "Could not stop reading, loved it!",
  "It’s a classic, and for good reason!"
]

bookings.each do |booking|
  rand(1..3).times do
    user = buyers.sample
    comment = reviews_comments.sample
    ReservationReview.create!(
      booking: booking,
      user: user,
      score: rand(3..5),
      comment: comment
    )
  end
end

puts "Seeding complete!"
