class GaleryPhotosController < ApplicationController

  def create
    @galery_photo = GaleryPhoto.new(params[:galery_photo])
    @galery_photo.save
    
    redirect_to :back
  end
  
  def destroy
    @galery_photo = GaleryPhoto.find params[:id]
    @galery_photo.galery.galery_photos.delete @galery_photo
    
    redirect_to :back
  end
end
