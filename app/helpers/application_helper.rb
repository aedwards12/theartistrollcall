module ApplicationHelper

 def get_votes_for_artist(id, video_id)
    @artist = Artist.find(id)
    @artist_count = @artist.get_upvotes(vote_scope: "video_#{video_id}").size - @artist.get_downvotes(vote_scope: "video_#{video_id}").size
  end
end
