class VideoController < ApplicationController
  def video_params
    params.require(:video).permit(:url, tag_list: [])
  end
end
