# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Artist.create([
  {twitter_screen_name: "AnthonyEdwardsj", twitter_img_url: "http://pbs.twimg.com/profile_images/378800000110195325/1f6209cdf7cf3c03aec4e700a5290e83_normal.jpeg", twitter_id: 0, name: "Anthony Edwards Jr"},
  {twitter_screen_name: "luamky", twitter_img_url: "https://pbs.twimg.com/profile_images/378800000410691785/360908c77177ae269a31f335628b7296_normal.jpeg", twitter_id: 1, name: "Luam"},
  {twitter_screen_name: "ValentineNorton", twitter_img_url: "https://pbs.twimg.com/profile_images/608854862235697152/4gf4LiBK_normal.jpg",twitter_id: 2, name: "Valentine Norton"}
  ])
Video.create([{url: "qXR0ujpNHVM"}, {url: "JV3VOoWH_yg"}, {url: "NoZU7T4CcoI"}])
Video.all.each do |vid|
  vid.set_yt_data
end

['dancer(s)', 'choreographer(s)', 'asst choreographer(s)'].each do |role|
  Role.create(label: role)
end

5.times do
  ArtistVideo.create( artist_id: [1,2,3].sample,  video_id: [1,2,3].sample, role_id: [0,1,2].sample )
end


