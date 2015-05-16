# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Artist.create([
  {twitter_screen_name: "AnthonyEdwardsj", twitter_img_url: "http://pbs.twimg.com/profile_images/378800000110195325/1f6209cdf7cf3c03aec4e700a5290e83_normal.jpeg"},
  {twitter_screen_name: "OoohTRaw", twitter_img_url: "http://pbs.twimg.com/profile_images/577614717545541632/ohqZaL1t_normal.jpeg",twitter_id: "98922435", name: "TeeTee"},
  {twitter_screen_name: "SarenaBahad", twitter_img_url: "http://pbs.twimg.com/profile_images/460790894203920384/-e-2y7aa_normal.jpeg", twitter_id: "24548534", name: "Sarena Bahad"}
  ])

Video.create([ {url: '9ypdIf85gI'}, {url: "qXR0ujpNHVM"}, {url: "JV3VOoWH_yg"}, {url: "NoZU7T4CcoI"}])

5.times do
  ArtistVideo.create( artist_id: rand(3),  video_id: rand(4), artist_role: rand(3))
end

