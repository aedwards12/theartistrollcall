FactoryGirl.define do
  factory :role do
    label "Dancer"
  end

  factory :video do
    url "ZYkmsFBcHxk"
    yt_title "Tory Lanez - N.A.M.E. | @AntoineTroupe Choreography"
    yt_description "Hope you enjoy. Learn this routine on my site and send me a video of you doing it!! Find the tutorial at antoinetroupe.me"
    yt_author "Antoine Troupe"
    yt_pub_date "2016-02-27T02:58:38.000Z"
  end

  factory :artist do
    first_name "Anthony"
    last_name "Edwards"
    name "Anthony Edwards Jr"
    city "Saugerties"
    state "New York"
    twitter_id "30777203"
    twitter_img_url "http://pbs.twimg.com/profile_images/378800000110195325/1f6209cdf7cf3c03aec4e700a5290e83_normal.jpeg"
    twitter_screen_name "AnthonyEdwardsj"
  end

  factory :artist_video do
    association :artist
    association :role
    association :video
  end
end