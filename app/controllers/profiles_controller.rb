class ProfilesController < ApplicationController
  def create
    response = RestClient.get('https://graph.facebook.com/anthony.j.edwards.79')
    # nokogiri this page get user image to get id then do a look up
    Rails.logger.ap response
    # artist = Artist.find(create_params[:id])
    # if artist
    #   #profile lookup
    #   fb_node = lookupcreate_params[:handle]

    #   if fb_node
    #     Profile.create(type: create_params[:type],
    #       profile_handle: fb_node[:handle],
    #       profile_img_url:fb_node[:handle],
    #       profile_id: fb_node[:id],
    #       artist_id: artist.id
    #     )
    #   end
    # end
  end

  def new

  end

  private

  def create_params
    params.require(:profile).permit(:id, :profile_handle, :type)
  end

end
