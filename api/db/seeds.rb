# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
images_path = Rails.root.join('public', 'uploads', 'seeds')
ActiveRecord::Base.transaction do
  artists = Artist.create([{name: 'Ivan'}, {name: 'John'}, {name: 'Frank'}])
  artworks = artists.map do |artist|
    {
      title: "Artwork by #{artist.name}", description: "Some Artwork",
      artist_id: artist.id, price: rand(100..1_000_000),
      width: rand(1...200), height: rand(1...200), depth: rand(1...200)
    }
  end
  artworks = Artwork.create(artworks)
  files = Dir["#{images_path}/*"].in_groups_of(4).map(&:compact)
  images1 = files[0].map do |image|
    { file: File.open(image), artwork_id: artworks[0].id }
  end

  images2 = files[1].map do |image|
    { file: File.open(image), artwork_id: artworks[1].id }
  end

  images3 = files[2].map do |image|
    { file: File.open(image), artwork_id: artworks[2].id }
  end

  Image.create(images1 | images2 | images3)
end
