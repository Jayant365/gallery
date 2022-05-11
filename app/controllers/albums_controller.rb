class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = current_user.albums
    @q = current_user.albums.ransack(params[:q])
    @albums = @q.result.includes(:tags)
  end

  def show
  end

  def edit
  end

  def update
    if @album.update(album_params)
      NotificationMailer.album_notification(current_user.email).deliver_later if @album.publish?
      redirect_to album_path(@album)
    
    else
      render :edit, status: :unprocessable_entity
    end
  end

  
  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.new(album_params)

    if @album.save
      NotificationMailer.album_notification(current_user.email).deliver_later if @album.publish?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy

    redirect_to albums_path , status: :see_other
  end

  def purge
    album = Album.find_by(id: params[:album_id])
    attachment = ActiveStorage::Attachment.find(params[:attachment_id])
    attachment.purge
    redirect_to album_path(album), notice: "Image deleted"
  end


  private
  def album_params
    params.require(:album).permit(:title, :description, :tagged, :cover_image, :publish, images: [] )
  end

  def load_album
    @album = Album.find(params[:id])
  end
end
