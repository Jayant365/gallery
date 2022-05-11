class HomeController < ApplicationController
  def index
    @albums = if user_signed_in?
                current_user.albums.where(publish: true)
              else
                Album.where(publish: true)
              end
    @q = @albums.ransack(params[:q])
    @albums = @q.result.includes(:tags)
  end
end