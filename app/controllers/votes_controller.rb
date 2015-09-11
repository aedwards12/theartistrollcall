class VotesController < ApplicationController

  def up_vote
    load_artist
    @artist.upvote_from current_user, vote_scope: "video_#{params["video_id"]}"
    @artist_count = @artist.get_upvotes(vote_scope: "video_#{params["video_id"]}").size - @artist.get_downvotes(vote_scope: "video_#{params["video_id"]}").size
  end

  def down_vote
    load_artist
    @artist.downvote_from current_user, vote_scope: "video_#{params["video_id"]}"
    @artist_count = @artist.get_upvotes(vote_scope: "video_#{params["video_id"]}").size - @artist.get_downvotes(vote_scope: "video_#{params["video_id"]}").size
  end

  private

  def load_artist
    @artist = Artist.find(params[:id])
  end
end
