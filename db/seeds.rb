10.times do
  Video.create!(title: Faker::Lorem.sentence, url: Faker::Internet.url)
end
